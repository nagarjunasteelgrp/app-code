class ApiUrl {
  //----------------------BaseURL--------------------------------//
  static const String productionUrl =
      'https://nagarjuna-crm-backend-309427312636.asia-south1.run.app/api/v1/';

  // Override for test builds with:
  // flutter build apk --dart-define=API_BASE_URL=http://<host>:3000/api/v1/
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: productionUrl,
  );

  static String localUrl =
      'https://0bc3-2405-201-2024-aa28-c86a-27ea-ddfa-1faf.ngrok-free.app/api/v1/';

  static String qaUrl = 'https://api.qa.nagarjunacrm.com/api/v1/';

  static String devUrl = 'https://api.dev.nagarjunacrm.com/api/v1/';

  //----------------------API Routs--------------------------------//

  static String checkInUrl = '${baseUrl}attendance';

  static String followUpsUrl = '${baseUrl}followUp';

  static String sendMessageUrl = '${baseUrl}messages';

  static String followUpsPutUrl = '${baseUrl}followUp';

  static String createContactUrl = '${baseUrl}contacts';

  static String trackingInfoUrl = '${baseUrl}activities';

  static String contactListUrl(int id, String type) =>
      '${baseUrl}contacts?userId=$id&contactType=$type';

  static String autoTrackingUrl = '${baseUrl}activities';

  static String trackingBatchUrl = '${baseUrl}activities/batch';

  static String trackingNotesUrl = '${baseUrl}tracking-notes';

  static String trackingImageUrl = '${baseUrl}tracking-images';

  static String loginUrl = '${baseUrl}users/login/salesperson';

  static String resetEmailUrl = '${baseUrl}auth/resetPassword';

  static String checkOutUrl(int id) => '${baseUrl}attendance/$id';

  static String getTaskListUrl(int id) => '${baseUrl}task/user/$id';

  static String contactUpdateUrl(int id) => '${baseUrl}contacts/$id';

  static String contactDetailsUrl(int id) => '${baseUrl}contacts/$id';

  static String relatedContactsListUrl = '${baseUrl}related-contacts';

  static String checkInListUrl(int id) => '${baseUrl}attendance/user/$id';

  static String matchUserTokenUrl(int userId) => '${baseUrl}users/$userId';

  static String trackingInfoListUrl(int dealerId) =>
      '${baseUrl}activities?dealerId=$dealerId';

  static String myProgressUrl(int id, dynamic startDate, dynamic endDate) =>
      '${baseUrl}app-statistics?userId=$id&fromDate=$endDate&toDate=$startDate';

  static String taskUrl(int id) => '${baseUrl}communications/user/$id';

  static String overallEnrollmentUrl(String period, int id) =>
      '${baseUrl}web-statistics/over-all-enrollment?period=$period&userId=$id';

  static String overallDistanceUrl(String period, int id) =>
      '${baseUrl}web-statistics/over-all-distance?period=$period&userId=$id';

  static String statusUpdateUrl(int statusId) =>
      '${baseUrl}task/$statusId/status';

  static String taskByUserIdUrl(int userId) => '${baseUrl}task?userId=$userId';

  static String messageFetching(int userId) =>
      '${baseUrl}messages?userId=$userId';

  static String updateDisplayPictureUrl() =>
      '${baseUrl}users/updateProfilePicture';

  static String followUpsUrlByUserId(userId, status, period) =>
      '${baseUrl}followUp/?userId=$userId&status=$status&period=$period';

  static String followUpsUrlByUserIdForNotification(userId) =>
      '${baseUrl}followUp/?userId=$userId&status=pending&period=today';

  static String followUpsNotification(userId) =>
      '${baseUrl}followUp/notification?userId=$userId';

  static String deleteAllNotification = '${baseUrl}followUp/clearnotification';

  static String activitiesUrl(userId, startTime, endTime) =>
      '${baseUrl}activities?userId=$userId&startTime=$startTime&endTime=$endTime';

  static String monthlyReportUrl(dbName, empCode, month, indicator) =>
      'http://103.138.45.226:8023/api/masters/getTargetAchivedAmount?dbName=$dbName&empcode=$empCode&Month=$month&vIndicator=$indicator';

  static String monthlySalesQtyUrl(month, indicator) =>
      'http://103.138.45.226:8023/api/masters/CBS_SalesQtyTargetAcheivment_CRM?vMonth=$month&vIndicator=$indicator';

  static String estimationAndQty(month, year, slpId) =>
      '${baseUrl}master-dashbord/estimation-and-qty?year=$year&month=$month&slpId=$slpId';
}
