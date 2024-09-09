import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../screens/login_screen.dart';  // Import the LoginScreen

class WeatherScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  WeatherScreen({super.key});  // Controller for city input

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);  // Access WeatherProvider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),  // Add a back arrow icon
          onPressed: () {
            // Navigate back to the LoginScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.indigoAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enter City Name',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              
              // Custom Input Field
              TextField(
                controller: _cityController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'City',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Custom Button
              ElevatedButton(
                onPressed: () {
                  if (_cityController.text.isNotEmpty) {
                    weatherProvider.fetchWeather(_cityController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                child: const Text('Get Weather'),
              ),
              const SizedBox(height: 30),
              
              // Display Weather Data
              weatherProvider.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : weatherProvider.weather != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'City: ${weatherProvider.weather!.city}',
                              style: const TextStyle(fontSize: 26, color: Colors.white),
                            ),
                            Text(
                              'Temperature: ${weatherProvider.weather!.temperature}°C',
                              style: const TextStyle(fontSize: 22, color: Colors.white70),
                            ),
                            Text(
                              'Description: ${weatherProvider.weather!.description}',
                              style: const TextStyle(fontSize: 20, color: Colors.white60),
                            ),
                          ],
                        )
                      : const Text(
                          'No weather data available.',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
