import 'dart:convert';
import 'package:brazeellian_community/constant/constant.dart';
import 'package:http/http.dart' as http;

import '../../Models/signUpModel.dart';

class ApiServicesforSignUp {
  static Future<SignUpResponse> signup(String email, String password, String name) async {
    const String URL = "${Constants.baseUrl}${Constants.registerUser}"; // Replace 'Constants.baseUrl' with your actual base URL.
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
      'name': name,
    };
    final response = await http.post(
      Uri.parse(URL),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    final String res = response.body;
    if (res != 'null') {
      print(res);
      try {
        final jsonData = json.decode(res) as Map<String, dynamic>;
        // Assuming the response follows the structure of SignUpResponse
        return SignUpResponse.fromJson(jsonData);
      } catch (e) {
        // Handle parsing error
        return SignUpResponse( error: e.toString());
      }
    }
    // Return an error response if the server response is 'null'
    return SignUpResponse(error: "Server returned null response");
  }
}
