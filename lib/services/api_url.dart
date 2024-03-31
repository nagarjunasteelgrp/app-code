class ApiUrl{

  static String baseUrl = 'http://172.178.89.198:3000/api/v1/';

  static String loginUrl = '${baseUrl}users/login';
  static String resetEmailUrl = '${baseUrl}auth/resetPassword';


  static String createContactUrl = '${baseUrl}contacts';

  static String listOfContactUrl = '${baseUrl}contacts';

  static String contactDetailsUrl(int id) => '${baseUrl}contacts/$id';

}