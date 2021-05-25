import 'dart:convert';

import 'package:http/http.dart' as http;

class WebApi {
  final URL =
      'https://covid-data-service-gtudpqxjma-as.a.run.app/api/v1/covid-19/laos/cases';
  // final URL = 'http://192.168.0.101:8989/api/v1/covid-19/laos/cases';

  Future<Map<String, dynamic>> getCovidCasesData() async {
    final response = await http.get(
      Uri.parse(URL),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load address data');
  }
}
