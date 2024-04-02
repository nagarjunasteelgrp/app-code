class ApiUrl{

  static String baseUrl = 'https://crm.murali.world/api/v1/';

  static String loginUrl = '${baseUrl}users/login';

  static String resetEmailUrl = '${baseUrl}auth/resetPassword';

  static String createContactUrl = '${baseUrl}contacts';

  static String listOfContactUrl = '${baseUrl}contacts';

  static String contactDetailsUrl(int id) => '${baseUrl}contacts/$id';

  static String relatedContactsListUrl = '${baseUrl}related-contacts';

  static String trackingInfoUrl = '${baseUrl}tracking-info';
  static String trackingNotesUrl = '${baseUrl}tracking-notes';
  static String trackingImageUrl = '${baseUrl}tracking-images';
  static String trackingInfoListUrl(int id) => '${baseUrl}tracking-info/$id';


  static String getTaskListUrl(int id) => '${baseUrl}tasks/user/$id';


  static String checkInListUrl(int id) => '${baseUrl}attendance/user/$id';



  static String checkInUrl = '${baseUrl}attendance';
  static String checkOutUrl(int id) => '${baseUrl}attendance/$id';



}