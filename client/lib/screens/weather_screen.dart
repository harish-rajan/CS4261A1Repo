import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../screens/login_screen.dart';  // Import the LoginScreen

class WeatherScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();  // Controller for city input

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);  // Access WeatherProvider

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),  // Add a back arrow icon
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
        decoration: BoxDecoration(
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
              Text(
                'Enter City Name',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              
              // Custom Input Field
              TextField(
                controller: _cityController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'City',
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Custom Button
              ElevatedButton(
                onPressed: () {
                  if (_cityController.text.isNotEmpty) {
                    weatherProvider.fetchWeather(_cityController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                child: Text('Get Weather'),
              ),
              SizedBox(height: 30),
              
              // Display Weather Data
              weatherProvider.isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : weatherProvider.weather != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'City: ${weatherProvider.weather!.city}',
                              style: TextStyle(fontSize: 26, color: Colors.white),
                            ),
                            Text(
                              'Temperature: ${weatherProvider.weather!.temperature}°C',
                              style: TextStyle(fontSize: 22, color: Colors.white70),
                            ),
                            Text(
                              'Description: ${weatherProvider.weather!.description}',
                              style: TextStyle(fontSize: 20, color: Colors.white60),
                            ),
                          ],
                        )
                      : Text(
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
