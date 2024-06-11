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
      headers:  await getHeaders(),
      body: jsonEncode({
        "userId": userId,
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


  Future<http.Response> listOfRelatedContact() async {
    final response = await http.get(
      Uri.parse(ApiUrl.relatedContactsListUrl),
      headers:  await getHeaders(),
    );
    print("LIST OF RELATED CONTACT STATUS CODE : ${response.statusCode}");
    print("LIST OF RELATED CONTACT BODY : ${response.body}");
    return response;
  }


  Future<http.Response> contactDetails({required int id}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.contactDetailsUrl(id)),
      headers:  await getHeaders(),
    );
    print("CONTACT DETAILS STATUS CODE : ${response.request}");
    print("CONTACT DETAILS STATUS CODE : ${response.statusCode}");
    print("CONTACT DETAILS BODY : ${response.body}");
    return response;
  }

  Future<http.Response> contactListAPI({required String type}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.contactListUrl(userId!,type)),
      headers:  await getHeaders(),
    );
    print("CONTACT LIST STATUS CODE : ${response.request}");
    print("CONTACT LIST STATUS CODE : ${response.statusCode}");
    print("CONTACT LIST BODY : ${response.body}");
    return response;
  }

  Future<http.Response> contactUpdate({
    String? personName,
    String? companyName,
    String? email,
    String? phone,
    String? contactType,
    String? taxId,
    String? address,
    String? description,
    int? userId,
    int? contactUserId,
  }) async {
    final response = await http.put(
      Uri.parse(ApiUrl.contactUpdateUrl(contactUserId!)),
      headers:  await getHeaders(),
      body: jsonEncode({
        "personName": personName,
        "companyName": companyName,
        "phone": phone,
        "email": email,
        "taxId": taxId,
        "contactType": contactType,
        "address": address,
        "description": description,
        "userId": userId,
      }),
    );
    print("CREATE CONTACT STATUS CODE : ${response.statusCode}");
    print("CREATE CONTACT BODY : ${response.body}");
    return response;
  }

  Future<http.Response> trackingNotes({String? description,int? trackingInfoId}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.trackingNotesUrl),
      headers:  await getHeaders(),
      body: jsonEncode({"description": description,"trackingInfoId": trackingInfoId}),
    );
    print("TRACKING NOTES STATUS CODE : ${response.statusCode}");
    print("TRACKING NOTES BODY : ${response.body}");
    return response;
  }

  Future<http.Response> trackingInfo({double? latitude, double? longitude,String? address,int? dealerId}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.trackingInfoUrl),
      headers:  await getHeaders(),
      body: jsonEncode({
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "trackingType": "captured",
      "userId": userId,
        "dealerId": dealerId
      }),
    );
    print("TRACKING INFO STATUS CODE : 1${response.request}");
    print("TRACKING INFO STATUS CODE : 2${response.body}");
    print("TRACKING INFO STATUS CODE : 3${response.statusCode}");
    print("TRACKING INFO BODY : ${response.body}");
    return response;
  }

  Future<http.Response> autoTrackingAPI({double? latitude, double? longitude,String? address}) async {
    print("latitude : $latitude longitude : $longitude address : $address userId : $userId");
    final response = await http.post(
      Uri.parse(ApiUrl.autoTrackingUrl),
      headers: await getHeaders(),
      body: jsonEncode({
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "trackingType": "auto",
        "userId": userId
      }),
    );
    print("SALES PERSON INFO STATUS CODE : 1${response.request}");
    print("SALES PERSON INFO STATUS CODE : 2${response.body}");
    print("SALES PERSON INFO STATUS CODE : 3${response.statusCode}");
    print("SALES PERSON INFO BODY : ${response.body}");
    return response;
  }

  Future<http.Response> trackingImages({
    required int trackingInfoId,
    required File image,
    required String imageType,
  }) async {
    var headers = await getHeaders();
    var request = http.MultipartRequest('POST',Uri.parse(ApiUrl.trackingImageUrl));
    request.headers.addAll(headers);
    request.fields['trackingInfoId'] = trackingInfoId.toString();
    request.fields['type'] = imageType.toString();
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("TRACKING IMAGES STATUS CODE REQUEST: ${response.request}");
    print("TRACKING IMAGES STATUS CODE : ${response.statusCode}");
    print("TRACKING IMAGES BODY : ${response.body}");
    return response;
  }

  Future<http.Response> trackingInfoList({required int id}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.trackingInfoListUrl(id)),
      headers:  await getHeaders(),
    );
    print("TRACKING OF LIST REQUEST CODE : ${response.request}");
    print("TRACKING OF LIST STATUS CODE : ${response.statusCode}");
    print("TRACKING OF LIST BODY : ${response.body}");
    return response;
  }

  Future<http.Response> getTaskList({required int id}) async {
    final response = await http.get(
      Uri.parse(ApiUrl.getTaskListUrl(id)),
      headers:  await getHeaders(),
    );
    print("GET TASK OF LIST STATUS CODE : ${response.statusCode}");
    print("GET TASK OF LIST BODY : ${response.body}");
    return response;
  }

  Future<http.Response> checkInList() async {
    final response = await http.get(
      Uri.parse(ApiUrl.checkInListUrl(userId ?? 0)),
      headers:  await getHeaders(),
    );
    print("CHECK IN OF LIST STATUS CODE : ${response.statusCode}");
    print("CHECK IN OF LIST BODY : ${response.body}");
    return response;
  }


  Future<http.Response> checkInAPI({int? userId,}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.checkInUrl),
      headers:  await getHeaders(),
      body: jsonEncode({
        "userId": userId,
        "clockIn": DateTime.now().toIso8601String()}),
    );
    print("CHECK IN  STATUS CODE : ${response.statusCode}");
    print("CHECK IN  BODY : ${response.body}");
    return response;
  }
  
  Future<http.Response> checkOutAPI({required int checkInId , int? userId, dynamic checkInTime}) async {
    print("----------------------");
    final response = await http.put(
      Uri.parse(ApiUrl.checkOutUrl(checkInId)),
      headers:  await getHeaders(),
      body: jsonEncode({
        "userId": userId,
        "clockIn": checkInTime,
        "clockOut": DateTime.now().toIso8601String()}),
    );
    print("CHECK OUT  STATUS CODE : ${response.request}");
    print("CHECK OUT  STATUS CODE : ${response.body}");
    print("CHECK OUT  STATUS CODE : ${response.statusCode}");
    print("CHECK OUT  BODY : ${response.body}");
    return response;
  }


  Future<http.Response> myProgressAPI({dynamic startDate , dynamic endDate}) async {
    print("myProgressAPI---------------------- $userId  ||  ${startDate}  ||  $endDate");
    final response = await http.get(Uri.parse(ApiUrl.myProgressUrl(userId!,startDate, endDate)),
      headers:  await getHeaders(),
    );
    print("MY PROGRESS  STATUS CODE : ${response.request}");
    print("MY PROGRESS  STATUS CODE : ${response.body}");
    print("MY PROGRESS  STATUS CODE : ${response.statusCode}");
    print("MY PROGRESS  BODY : ${response.body}");
    return response;
  }

  Future<http.Response>taskAPI() async {
    print("taskAPI---------------------- $userId");
    final response = await http.get(Uri.parse(ApiUrl.taskUrl(userId ?? 0)),
      headers:  await getHeaders(),
    );
    print("TASK STATUS CODE : ${response.request}");
    print("TASK STATUS CODE : ${response.body}");
    print("TASK STATUS CODE : ${response.statusCode}");
    print("TASK BODY : ${response.body}");
    return response;
  }

  Future<http.Response>overallEnrollmentAPI({String? filter}) async {
    print("OVERALL ENROLLMENT---------------------- $userId");
    final response = await http.get(Uri.parse(ApiUrl.overallEnrollmentUrl(filter! , userId ?? 0)),
      headers:  await getHeaders(),
    );
    print("OVERALL ENROLLMENT STATUS CODE : ${response.request}");
    print("OVERALL ENROLLMENT STATUS CODE : ${response.body}");
    print("OVERALL ENROLLMENT STATUS CODE : ${response.statusCode}");
    print("OVERALL ENROLLMENT BODY : ${response.body}");
    return response;
  }

  Future<http.Response> statusUpdateAPI({String? status,int? statusId}) async {
    print("STATUS UPDATE---------------------- $status &&  $statusId");
    final response = await http.patch(Uri.parse(ApiUrl.statusUpdateUrl(statusId!)),
      headers:  await getHeaders(),
      body: jsonEncode({
        "status": status,
      }),
    );

    print("UPDATE STATUS CODE : ${response.statusCode}");
    print("UPDATE STATUS BODY : ${response.body}");
    return response;
  }


  Future<http.Response>taskByUserIdAPI() async {
    print("TASK BY USERID---------------------- $userId");
    final response = await http.get(Uri.parse(ApiUrl.taskByUserIdUrl(userId!)),
      headers:  await getHeaders(),
    );
    print("TASK BY USERID STATUS CODE : ${response.request}");
    print("TASK BY USERID STATUS CODE : ${response.body}");
    print("TASK BY USERID STATUS CODE : ${response.statusCode}");
    print("TASK BY USERID BODY : ${response.body}");
    return response;
  }

  Future<http.Response> sendMessage({String? message}) async {
    final response = await http.post(
      Uri.parse(ApiUrl.sendMessageUrl),
      headers:  await getHeaders(),
      body: jsonEncode({
        "userId": userId,
        "message": message
      }),
    );
    print("SEND MESSAGE STATUS CODE : ${response.request}");
    print("SEND MESSAGE STATUS CODE : ${response.statusCode}");
    print("SEND MESSAGE BODY : ${response.body}");
    return response;
  }

}