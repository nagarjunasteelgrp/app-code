import 'dart:convert';
import 'dart:io';
import 'package:digital_lync/constants/global.dart';
import 'package:intl/intl.dart';
import 'api_url.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<http.Response> login({String? email, String? password}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"username": email, "password": password}),
    );
    print("login : ${response.request}");
    print("login : ${response.statusCode}");
    print("login : ${response.body}");
    return response;
  }

  Future<http.Response> resetEmail({String? email}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.resetEmailUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );
    print("resetEmail : ${response.request}");
    print("resetEmail : ${response.statusCode}");
    print("resetEmail : ${response.body}");
    return response;
  }

  Future<http.Response> createContact({
    String? personName,
    String? companyName,
    String? email,
    String? phone,
    String? phone2,
    String? landline,
    String? gstNumber,
    String? contactType,
    String? taxId,
    String? address,
    String? description,
  }) async {
    final response = await http.post(
      Uri.parse(ApiUrl.createContactUrl),
      headers: await getHeaders(),
      body: jsonEncode({
        "userId": userId,
        "personName": personName,
        "companyName": companyName,
        "email": email,
        "phone": phone,
        "phone2": phone2,
        "landline": landline,
        "gstNumber": gstNumber,
        "contactType": contactType,
        "taxId": taxId,
        "address": address,
        "description": description,
      }),
    );
    print("createContact : ${response.request}");
    print("createContact : ${response.statusCode}");
    print("createContact : ${response.body}");
    return response;
  }

  Future<http.Response> listOfRelatedContact() async {
    final response = await http.get(
      Uri.parse(ApiUrl.relatedContactsListUrl),
      headers: await getHeaders(),
    );
    print("listOfRelatedContact : ${response.request}");
    print("listOfRelatedContact : ${response.statusCode}");
    print("listOfRelatedContact : ${response.body}");
    return response;
  }

  Future<http.Response> contactDetails({required int id}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.contactDetailsUrl(id)),
      headers: await getHeaders(),
    );
    print("contactDetails : ${response.request}");
    print("contactDetails : ${response.statusCode}");
    print("contactDetails : ${response.body}");
    return response;
  }

  Future<http.Response> contactListAPI({required String type}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.contactListUrl(userId!, type)),
      headers: await getHeaders(),
    );
    print("contactListAPI : ${response.request}");
    print("contactListAPI : ${response.statusCode}");
    print("contactListAPI : ${response.body}");
    return response;
  }

  Future<http.Response> contactUpdate({
    String? personName,
    String? companyName,
    String? email,
    String? phone,
    String? phone2,
    String? landline,
    String? gstNumber,
    String? contactType,
    String? address,
    String? description,
    int? contactUserId,
  }) async {
    final response = await http.put(
      Uri.parse(ApiUrl.contactUpdateUrl(contactUserId!)),
      headers: await getHeaders(),
      body: jsonEncode({
        "userId": userId,
        "personName": personName,
        "companyName": companyName,
        "email": email,
        "phone": phone,
        "phone2": phone2,
        "landline": landline,
        "gstNumber": gstNumber,
        "contactType": contactType,
        "address": address,
        "description": description,
      }),
    );
    print("contactUpdate : ${response.request}");
    print("contactUpdate : ${response.statusCode}");
    print("contactUpdate : ${response.body}");
    return response;
  }

  Future<http.Response> trackingNotes(
      {String? description, int? trackingInfoId}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.trackingNotesUrl),
      headers: await getHeaders(),
      body: jsonEncode(
          {"description": description, "trackingInfoId": trackingInfoId}),
    );
    print("trackingNotes : ${response.request}");
    print("trackingNotes : ${response.statusCode}");
    print("trackingNotes : ${response.body}");
    return response;
  }

  Future<http.Response> trackingInfo(
      {double? latitude,
      double? longitude,
      String? address,
      int? dealerId}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.trackingInfoUrl),
      headers: await getHeaders(),
      body: jsonEncode({
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "trackingType": "captured",
        "userId": userId,
        "dealerId": dealerId,
        "time": DateTime.now().toIso8601String()
      }),
    );
    print("trackingInfo : ${response.request}");
    print("trackingInfo : ${response.statusCode}");
    print("trackingInfo : ${response.body}");
    return response;
  }

  Future<http.Response> autoTrackingAPI(
      {double? latitude, double? longitude, String? address}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.autoTrackingUrl),
      headers: await getHeaders(),
      body: jsonEncode({
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "trackingType": "auto",
        "userId": userId,
        "time": DateTime.now().toIso8601String()
      }),
    );
    print("autoTrackingAPI : ${response.request}");
    print("autoTrackingAPI : ${response.statusCode}");
    print("autoTrackingAPI : ${response.body}");
    return response;
  }

  Future<http.Response> trackingImages({
    required int trackingInfoId,
    required File image,
    required String imageType,
  }) async {
    var headers = await getHeaders();
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.trackingImageUrl));
    request.headers.addAll(headers);
    request.fields['trackingInfoId'] = trackingInfoId.toString();
    request.fields['type'] = imageType.toString();
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("trackingImages : ${response.request}");
    print("trackingImages : ${response.statusCode}");
    print("trackingImages : ${response.body}");
    return response;
  }

  Future<http.Response> trackingInfoList({required int id}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.trackingInfoListUrl(id)),
      headers: await getHeaders(),
    );
    print("trackingInfoList : ${response.request}");
    print("trackingInfoList : ${response.statusCode}");
    print("trackingInfoList : ${response.body}");
    return response;
  }

  Future<http.Response> getTaskList({required int id}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.getTaskListUrl(id)),
      headers: await getHeaders(),
    );
    print("getTaskList : ${response.request}");
    print("getTaskList : ${response.statusCode}");
    print("getTaskList : ${response.body}");
    return response;
  }

  Future<http.Response> checkInList() async {
    final response = await http.get(
      Uri.parse(ApiUrl.checkInListUrl(userId ?? 0)),
      headers: await getHeaders(),
    );
    print("checkInList : ${response.request}");
    print("checkInList : ${response.statusCode}");
    print("checkInList : ${response.body}");
    return response;
  }

  Future<http.Response> checkInAPI({
    int? userId,
  }) async {
    final response = await http.post(
      Uri.parse(ApiUrl.checkInUrl),
      headers: await getHeaders(),
      body: jsonEncode(
          {"userId": userId, "clockIn": DateTime.now().toIso8601String()}),
    );
    print("checkInAPI : ${response.request}");
    print("checkInAPI : ${response.statusCode}");
    print("checkInAPI : ${response.body}");
    return response;
  }

  Future<http.Response> checkOutAPI(
      {required int checkInId, int? userId, dynamic checkInTime}) async {
    final response = await http.put(
      Uri.parse(ApiUrl.checkOutUrl(checkInId)),
      headers: await getHeaders(),
      body: jsonEncode({
        "userId": userId,
        "clockIn": checkInTime,
        "clockOut": DateTime.now().toIso8601String()
      }),
    );
    print("checkOutAPI : ${response.request}");
    print("checkOutAPI : ${response.statusCode}");
    print("checkOutAPI : ${response.body}");
    return response;
  }

  Future<http.Response> myProgressAPI(
      {dynamic startDate, dynamic endDate}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.myProgressUrl(userId!, startDate, endDate)),
      headers: await getHeaders(),
    );
    print("myProgressAPI : ${response.request}");
    print("myProgressAPI : ${response.statusCode}");
    print("myProgressAPI : ${response.body}");
    return response;
  }

  Future<http.Response> taskAPI() async {
    final response = await http.get(
      Uri.parse(ApiUrl.taskUrl(userId ?? 0)),
      headers: await getHeaders(),
    );
    print("taskAPI : ${response.request}");
    print("taskAPI : ${response.statusCode}");
    print("taskAPI : ${response.body}");
    return response;
  }

  Future<http.Response> overallEnrollmentAPI({String? filter}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.overallEnrollmentUrl(filter!, userId ?? 0)),
      headers: await getHeaders(),
    );
    print("overallEnrollmentAPI : ${response.request}");
    print("overallEnrollmentAPI : ${response.statusCode}");
    print("overallEnrollmentAPI : ${response.body}");
    return response;
  }

  Future<http.Response> overallDistanceAPI({String? filter}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.overallDistanceUrl(filter!, userId ?? 0)),
      headers: await getHeaders(),
    );
    print("overallDistanceAPI : ${response.request}");
    print("overallDistanceAPI : ${response.statusCode}");
    print("overallDistanceAPI : ${response.body}");
    return response;
  }

  Future<http.Response> statusUpdateAPI({String? status, int? statusId}) async {
    final response = await http.patch(
      Uri.parse(ApiUrl.statusUpdateUrl(statusId!)),
      headers: await getHeaders(),
      body: jsonEncode({
        "status": status,
      }),
    );
    print("statusUpdateAPI : ${response.request}");
    print("statusUpdateAPI : ${response.statusCode}");
    print("statusUpdateAPI : ${response.body}");
    return response;
  }

  Future<http.Response> taskByUserIdAPI() async {
    final response = await http.get(
      Uri.parse(ApiUrl.taskByUserIdUrl(userId!)),
      headers: await getHeaders(),
    );
    print("taskByUserIdAPI : ${response.request}");
    print("taskByUserIdAPI : ${response.statusCode}");
    print("taskByUserIdAPI : ${response.body}");
    return response;
  }

  Future<http.Response> messageFetchingAPI() async {
    final response = await http.get(
      Uri.parse(ApiUrl.messageFetching(userId!)),
      headers: await getHeaders(),
    );
    print("messageFetchingAPI : ${response.request}");
    print("messageFetchingAPI : ${response.statusCode}");
    print("messageFetchingAPI : ${response.body}");
    return response;
  }

  Future<http.Response> updateDisplayPicture(
      int userId, File? imageFile) async {
    if (imageFile == null) {
      throw Exception("No image file provided");
    }
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(ApiUrl.updateDisplayPictureUrl()));
      request.fields['userId'] = userId.toString();
      request.files.add(await http.MultipartFile.fromPath(
        'profilePicture',
        imageFile.path,
      ));
      request.headers.addAll(await getHeaders()); // Add any required headers
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);
      return responseData;
    } catch (e) {
      print("Error in updateDisplayPicture API: $e");
      rethrow; // Rethrow the exception for higher-level handling if needed
    }
  }

  Future<http.Response> sendMessage({String? message}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.sendMessageUrl),
      headers: await getHeaders(),
      body: jsonEncode({"userId": userId, "message": message}),
    );
    print("sendMessage : ${response.request}");
    print("sendMessage : ${response.statusCode}");
    print("sendMessage : ${response.body}");
    return response;
  }

  Future<http.Response> followUpsApi(
      {int? dealerId, dynamic selectDate, String? notes}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.followUpsUrl),
      headers: await getHeaders(),
      body: jsonEncode({
        "dealerId": dealerId,
        "userId": userId,
        "followUpDate": selectDate,
        "notes": notes,
        "status": "pending"
      }),
    );
    print("followUpsApi : ${response.request}");
    print("followUpsApi : ${response.statusCode}");
    print("followUpsApi : ${response.body}");
    return response;
  }

  Future<http.Response> followUpsPutApi({int? followUpId}) async {
    final response = await http.put(
      Uri.parse(ApiUrl.followUpsPutUrl),
      headers: await getHeaders(),
      body: jsonEncode({"id": followUpId, "status": "done"}),
    );
    print("followUpsPutApi : ${response.request}");
    print("followUpsPutApi : ${response.statusCode}");
    print("followUpsPutApi : ${response.body}");
    return response;
  }

  Future<http.Response> followUpsByUserId(status, period) async {
    final response = await http.get(
      Uri.parse(ApiUrl.followUpsUrlByUserId(userId!, status, period)),
      headers: await getHeaders(),
    );
    print("followUpsByUserId : ${response.request}");
    print("followUpsByUserId : ${response.statusCode}");
    print("followUpsByUserId : ${response.body}");
    return response;
  }

  Future<http.Response> followUpsByUserIdForNotification() async {
    final response = await http.get(
      Uri.parse(ApiUrl.followUpsUrlByUserIdForNotification(userId!)),
      headers: await getHeaders(),
    );
    print("followUpsByUserIdForNotification : ${response.request}");
    print("followUpsByUserIdForNotification : ${response.statusCode}");
    print("followUpsByUserIdForNotification : ${response.body}");
    return response;
  }
}
