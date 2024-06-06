import 'package:digital_lync/constants/global.dart';

class ApiUrl{

  static String baseUrls = 'https://api.dev1.nagarjunacrm.com/api/v1/';
  static String baseUrl = 'https://api.app.nagarjunacrm.com/api/v1/';


  static String loginUrl = '${baseUrl}users/login';

  static String resetEmailUrl = '${baseUrl}auth/resetPassword';

  static String createContactUrl = '${baseUrl}contacts';

  static String contactDetailsUrl(int id) => '${baseUrl}contacts/$id';

  static String contactUpdateUrl(int id) => '${baseUrl}contacts/$id';

  static String contactListUrl(int id,String type) => '${baseUrl}contacts?userId=$id&contactType=$type';

  static String relatedContactsListUrl = '${baseUrl}related-contacts';

  static String trackingInfoUrl = '${baseUrl}activities';

  static String trackingNotesUrl = '${baseUrl}tracking-notes';

  static String trackingImageUrl = '${baseUrl}tracking-images';

  static String trackingInfoListUrl(int dealerId) => '${baseUrl}activities?dealerId=$dealerId';

  static String autoTrackingUrl = '${baseUrl}activities';

  static String getTaskListUrl(int id) => '${baseUrl}tasks/user/$id';

  static String checkInListUrl(int id) => '${baseUrl}attendance/user/$id';

  static String checkInUrl = '${baseUrl}attendance';

  static String checkOutUrl(int id) => '${baseUrl}attendance/$id';

  static String myProgressUrl(int id,dynamic startDate,dynamic endDate) => '${baseUrls}app-statistics?userId=$id&fromDate=$endDate&toDate=$startDate';

  static String taskUrl(int id) => '${baseUrls}communications/user/$id';

  static String overallEnrollmentUrl(String period) => '${baseUrls}web-statistics/over-all-enrollment?period=$period';

  static String statusUpdateUrl(int statusId) => '${baseUrls}tasks/$statusId/status';

  static String taskByUserIdUrl(int userId) => '${baseUrls}tasks?userId=$userId';

}