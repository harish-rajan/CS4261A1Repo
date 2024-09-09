import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier{
  Weather? _weather;
  bool _isLoading = false;
  final WeatherService _weatherService = WeatherService();

  Weather? get weather=> _weather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String city) async{
    _isLoading = true;
    notifyListeners();

    try{
      final data = await _weatherService.fetchWeather(city);
      _weather = Weather.fromJson(data);
    } catch(e){ 
      _weather = null;
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}