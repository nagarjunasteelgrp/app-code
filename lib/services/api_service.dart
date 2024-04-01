import 'dart:convert';
import 'dart:io';
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

  Future<http.Response> listOfRelatedContact({String? token}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.relatedContactsListUrl),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );
    print("LIST OF RELATED CONTACT STATUS CODE : ${response.statusCode}");
    print("LIST OF RELATED CONTACT BODY : ${response.body}");
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


  Future<http.Response> trackingNotes({String? token , String? description}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.trackingNotesUrl),
      headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
      body: jsonEncode({"description": description,"trackingInfoId": 1}),
    );
    print("TRACKING NOTES STATUS CODE : ${response.statusCode}");
    print("TRACKING NOTES BODY : ${response.body}");
    return response;
  }

  Future<http.Response> trackingInfo({String? token, double? latitude, double? longitude,String? address}) async {
    print("TRACKING MAP:-----1 ${latitude} : ${longitude} : ${address}");
    final response = await http.post(
      Uri.parse(ApiUrl.trackingInfoUrl),
      headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
      body: jsonEncode({"latitude": latitude,"longitude": longitude,"address": address}),
    );
    print("TRACKING INFO STATUS CODE : ${response.statusCode}");
    print("TRACKING INFO BODY : ${response.body}");
    return response;
  }

  Future<http.Response> trackingImages({
    required String token,
    required int trackingInfoId,
    required File image,
  }) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiUrl.trackingImageUrl));
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['trackingInfoId'] = trackingInfoId.toString();
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("TRACKING IMAGES STATUS CODE : ${response.statusCode}");
    print("TRACKING IMAGES BODY : ${response.body}");
    return response;
  }


}