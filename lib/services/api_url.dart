class ApiUrl {
//----------------------BaseURL--------------------------------//
  static String baseUrl = productionUrl;

  static String localUrl = 'http://192.168.29.54:4000/api/v1/';

  static String qaUrl = 'https://api.qa.nagarjunacrm.com/api/v1/';

  static String devUrl = 'https://api.dev.nagarjunacrm.com/api/v1/';

  static String productionUrl = 'https://api.app.nagarjunacrm.com/api/v1/';

//----------------------API Routs--------------------------------//

  static String checkInUrl = '${baseUrl}attendance';

  static String createContactUrl = '${baseUrl}contacts';

  static String loginUrl = '${baseUrl}users/login/salesperson';

  static String trackingInfoUrl = '${baseUrl}activities';

  static String resetEmailUrl = '${baseUrl}auth/resetPassword';

  static String contactUpdateUrl(int id) => '${baseUrl}contacts/$id';

  static String contactDetailsUrl(int id) => '${baseUrl}contacts/$id';

  static String contactListUrl(int id, String type) =>
      '${baseUrl}contacts?userId=$id&contactType=$type';

  static String trackingNotesUrl = '${baseUrl}tracking-notes';

  static String trackingImageUrl = '${baseUrl}tracking-images';

  static String relatedContactsListUrl = '${baseUrl}related-contacts';

  static String autoTrackingUrl = '${baseUrl}activities';

  static String getTaskListUrl(int id) => '${baseUrl}task/user/$id';

  static String checkInListUrl(int id) => '${baseUrl}attendance/user/$id';

  static String matchUserTokenUrl(int userId) => '${baseUrl}users/$userId';

  static String checkOutUrl(int id) => '${baseUrl}attendance/$id';

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

  static String sendMessageUrl = '${baseUrl}messages';

  static String followUpsUrl = '${baseUrl}followUp';

  static String followUpsPutUrl = '${baseUrl}followUp';

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
