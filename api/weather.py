from flask import Flask, request, jsonify
from dotenv import load_dotenv
import os
import requests

app = Flask(__name__)

# Load environment variables
load_dotenv()

def get_current_weather(city="Kansas City"):
    api_key = os.getenv("OPENWEATHER_API_KEY")
    request_url = f'http://api.openweathermap.org/data/2.5/weather?appid={api_key}&q={city}&units=imperial'
    weather_data = requests.get(request_url).json()
    return weather_data

# API Route to get weather as JSON
@app.route("/api/weather")
def weather_api():
    city = request.args.get("city")
    if not city or not city.strip():
        return jsonify({"error": "City name is required"}), 400

    weather_data = get_current_weather(city)
    
    if weather_data.get("cod") != 200:
        return jsonify({"error": "Unable to get weather for the specified city"}), 404

        
    headers = {
       'Cache-control': 'no-transform',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true'
    }
        
    # return jsonify({
    #     "city": weather_data["name"],
    #     "temperature": weather_data["main"]["temp"],
    #     "condition": weather_data["weather"][0]["description"]
    # }) , 200, headers

    return weather_data, 200, headers
    
    
if __name__ == "__main__":
    app.run(debug=True, port=5002)
