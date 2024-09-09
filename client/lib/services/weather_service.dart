import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService{
  // final String apiKey = 'aab2ede815a71ff9611dca381a6196a4';
  // final String baseURL = 'http://api.openweathermap.org/data/2.5/weather';
  final String baseURL = 'http://127.0.0.1:5002/api/weather';
  
  Future<Map<String, dynamic>> fetchWeather(String city) async {
    // final response = await http.get(Uri.parse('$baseURL?q=$city&appid=$apiKey&units=imperial'));
    final response = await http.get(Uri.parse('$baseURL?city=$city'));
      // final response = await http.get(Uri.parse('$baseURL?city=$city'),  headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load weather data");
    }
  }

}