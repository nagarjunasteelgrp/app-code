import 'dart:convert';
import 'api_url.dart';
import 'package:http/http.dart' as http;


class ApiServices {

  Future<Map<String, dynamic>> login({String? email, String? password}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"username": email, "password": password}),
    );
    print("LOGIN URL : ${ApiUrl.loginUrl}");
    print("LOGIN STATUS CODE : ${response.statusCode}");
    print("LOGIN BODY : ${response.body}");
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> resetEmail({String? email}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.resetEmailUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );
    print("RESET EMAIL STATUS CODE : ${response.statusCode}");
    print("RESET EMAIL BODY : ${response.body}");
    return jsonDecode(response.body);
  }


  Future<Map<String, dynamic>> createContact({
    String? token,
    String? personName,
    String? companyName,
    String? email,
    String? phone,
    String? taxId,
    String? contactType,
    String? address,
    String? description,
  }) async {
    final response = await http.post(
      Uri.parse(ApiUrl.createContactUrl),
      headers: {'Content-Type': 'application/json',
      'Bearer Token': token!},
      body: jsonEncode({
        "personName": personName,
        "companyName": companyName,
        "email": email,
        "phone": phone,
        "taxId": taxId,
        "contactType": contactType,
        "address": address,
        "description": description,
      }),
    );
    print("CREATE CONTACT STATUS CODE : ${response.statusCode}");
    print("CREATE CONTACT BODY : ${response.body}");
    return jsonDecode(response.body);
  }

}