import 'dart:convert';
import 'api_url.dart';
import 'package:http/http.dart' as http;


class ApiServices {

  Future<http.Response> login({String? email, String? password}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"username": email, "password": password}),
    );
    print("LOGIN URL : ${ApiUrl.loginUrl}");
    print("LOGIN STATUS CODE : ${response.statusCode}");
    print("LOGIN BODY : ${response.body}");
    return response;
  }

  Future<http.Response> resetEmail({String? email}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.resetEmailUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );
    print("RESET EMAIL STATUS CODE : ${response.statusCode}");
    print("RESET EMAIL BODY : ${response.body}");
    return response;
  }


  Future<http.Response> createContact({
    String? token,
    String? personName,
    String? companyName,
    String? email,
    String? phone,
    String? contactType,
    String? taxId,
    String? address,
    String? description,
  }) async {
    final response = await http.post(
      Uri.parse(ApiUrl.createContactUrl),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode({
        "personName": personName,
        "companyName": companyName,
        "email": email,
        "phone": phone,
        "contactType": contactType,
        "taxId": taxId,
        "address": address,
        "description": description,
      }),
    );
    print("CREATE CONTACT STATUS CODE : ${response.statusCode}");
    print("CREATE CONTACT BODY : ${response.body}");
    return response;
  }

  Future<http.Response> listOfContact({String? token}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.listOfContactUrl),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );
    print("LIST OF CONTACT STATUS CODE : ${response.statusCode}");
    print("LIST OF CONTACT BODY : ${response.body}");
    return response;
  }


  Future<http.Response> contactDetails({String? token,required int id}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.contactDetailsUrl(id)),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );
    print("CONTACT DETAILS STATUS CODE : ${response.statusCode}");
    print("CONTACT DETAILS BODY : ${response.body}");
    return response;
  }



}