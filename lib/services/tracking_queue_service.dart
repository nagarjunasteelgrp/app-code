import 'package:digital_lync/helper/shared_prefs_helper.dart';
import 'package:path/path.dart' as path_util;
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class QueuedTrackingPoint {
  const QueuedTrackingPoint({
    required this.pointId,
    required this.sessionId,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.accuracy,
    required this.speed,
    required this.heading,
    required this.capturedAt,
    required this.attempts,
  });

  final String pointId;
  final String sessionId;
  final int userId;
  final double latitude;
  final double longitude;
  final String address;
  final double? accuracy;
  final double? speed;
  final double? heading;
  final DateTime capturedAt;
  final int attempts;

  factory QueuedTrackingPoint.fromMap(Map<String, Object?> map) {
    return QueuedTrackingPoint(
      pointId: map['point_id']! as String,
      sessionId: map['session_id']! as String,
      userId: map['user_id']! as int,
      latitude: (map['latitude']! as num).toDouble(),
      longitude: (map['longitude']! as num).toDouble(),
      address: map['address']! as String,
      accuracy: (map['accuracy'] as num?)?.toDouble(),
      speed: (map['speed'] as num?)?.toDouble(),
      heading: (map['heading'] as num?)?.toDouble(),
      capturedAt: DateTime.parse(map['captured_at']! as String).toUtc(),
      attempts: map['attempts']! as int,
    );
  }

  Map<String, dynamic> toApiJson() => {
        'pointId': pointId,
        'sessionId': sessionId,
        'userId': userId,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'accuracy': accuracy,
        'speed': speed,
        'heading': heading,
        'capturedAt': capturedAt.toIso8601String(),
        'source': 'fused',
      };
}

class TrackingQueueService {
  TrackingQueueService._();

  static final TrackingQueueService instance = TrackingQueueService._();
  static const Uuid _uuid = Uuid();
  static const int maxPendingPoints = 10000;
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    final databasePath = await getDatabasesPath();
    _database = await openDatabase(
      path_util.join(databasePath, 'nagarjuna_tracking.db'),
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE tracking_queue (
            point_id TEXT PRIMARY KEY,
            session_id TEXT NOT NULL,
            user_id INTEGER NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            address TEXT NOT NULL,
            accuracy REAL,
            speed REAL,
            heading REAL,
            captured_at TEXT NOT NULL,
            status TEXT NOT NULL DEFAULT 'pending',
            attempts INTEGER NOT NULL DEFAULT 0,
            last_error TEXT,
            created_at TEXT NOT NULL
          )
        ''');
        await database.execute(
          'CREATE INDEX tracking_queue_status_time_idx ON tracking_queue(status, captured_at)',
        );
      },
    );
    return _database!;
  }

  Future<String> getOrCreateSessionId(int userId) async {
    final key = 'trackingSessionId_$userId';
    final existing = SharedPrefsHelper.getString(key);
    if (existing != null && existing.isNotEmpty) return existing;
    final sessionId = _uuid.v4();
    await SharedPrefsHelper.setString(key, sessionId);
    return sessionId;
  }

  Future<String> startNewSession(int userId) async {
    final sessionId = _uuid.v4();
    await SharedPrefsHelper.setString('trackingSessionId_$userId', sessionId);
    return sessionId;
  }

  Future<void> endSession(int userId) async {
    await SharedPrefsHelper.remove('trackingSessionId_$userId');
  }

  Future<String> enqueue({
    required int userId,
    required double latitude,
    required double longitude,
    required String address,
    required DateTime capturedAt,
    double? accuracy,
    double? speed,
    double? heading,
  }) async {
    final db = await database;
    final count = Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM tracking_queue WHERE status = ?',
            ['pending'],
          ),
        ) ??
        0;
    if (count >= maxPendingPoints) {
      throw StateError('Tracking queue is full');
    }

    final pointId = _uuid.v4();
    final sessionId = await getOrCreateSessionId(userId);
    await db.insert('tracking_queue', {
      'point_id': pointId,
      'session_id': sessionId,
      'user_id': userId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'accuracy': accuracy,
      'speed': speed,
      'heading': heading,
      'captured_at': capturedAt.toUtc().toIso8601String(),
      'status': 'pending',
      'attempts': 0,
      'created_at': DateTime.now().toUtc().toIso8601String(),
    });
    return pointId;
  }

  Future<List<QueuedTrackingPoint>> pendingPoints({
    required int userId,
    int limit = 100,
  }) async {
    final rows = await (await database).query(
      'tracking_queue',
      where: 'status = ? AND user_id = ?',
      whereArgs: ['pending', userId],
      orderBy: 'captured_at ASC',
      limit: limit,
    );
    return rows.map(QueuedTrackingPoint.fromMap).toList();
  }

  Future<int> pendingCount({required int userId}) async {
    return Sqflite.firstIntValue(
          await (await database).rawQuery(
            'SELECT COUNT(*) FROM tracking_queue WHERE status = ? AND user_id = ?',
            ['pending', userId],
          ),
        ) ??
        0;
  }

  Future<void> updateAddress({
    required String pointId,
    required String address,
  }) async {
    await (await database).update(
      'tracking_queue',
      {'address': address},
      where: 'point_id = ? AND status = ?',
      whereArgs: [pointId, 'pending'],
    );
  }

  Future<void> deleteAcknowledged(List<String> pointIds) async {
    if (pointIds.isEmpty) return;
    final placeholders = List.filled(pointIds.length, '?').join(',');
    await (await database).delete(
      'tracking_queue',
      where: 'point_id IN ($placeholders)',
      whereArgs: pointIds,
    );
  }

  Future<void> markRejected(String pointId, String reason) async {
    await (await database).rawUpdate(
      'UPDATE tracking_queue SET status = ?, last_error = ?, attempts = attempts + 1 WHERE point_id = ?',
      ['rejected', reason, pointId],
    );
  }

  Future<void> markRetry(List<String> pointIds, String reason) async {
    if (pointIds.isEmpty) return;
    final placeholders = List.filled(pointIds.length, '?').join(',');
    await (await database).rawUpdate(
      'UPDATE tracking_queue SET last_error = ?, attempts = attempts + 1 WHERE point_id IN ($placeholders)',
      [reason, ...pointIds],
    );
  }

  Future<void> cleanupRejected() async {
    final cutoff = DateTime.now()
        .toUtc()
        .subtract(const Duration(days: 7))
        .toIso8601String();
    await (await database).delete(
      'tracking_queue',
      where: 'status = ? AND created_at < ?',
      whereArgs: ['rejected', cutoff],
    );
  }
}
