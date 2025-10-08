//
//  WeatherManager.swift
//  Weather
//
//  Created by Tanmay Avinash Dabhade on 7/16/24.
//

import Foundation
import CoreLocation

class WeatherManager{
    //Two parameters latitude and longitude are in Core Location generated, we are using async and await and throws for errors.
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        
        
//        guard let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(latitude)&lon=\(longitude)&part={part}&appid=\("e6af6d4c93cb421326c76e8dbd9cc6ee")&units=metric") else
//            {fatalError("URL not found")}
        
        guard let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(latitude)&lon=\(longitude)&appid=\("e6af6d4c93cb421326c76e8dbd9cc6ee")&units=metric") else
            {fatalError("URL not found")}
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url)) //stored retrieved data in data and response variables
        
        //to make sure we have a response and response is HTTP 200
        guard (response as?  HTTPURLResponse)?.statusCode == 200 else {fatalError("Error Fetching weather Data")}
        
        let decodeData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodeData
    }
}




//model of response we get from api endpoint
struct ResponseBody: Decodable {
    var coord: CoordinateResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var wind: WindResponse
    var name: String
    var timezone: String
    var timezone_offset: Int
    var current: CurrentWeatherResponse
    var minutely: [MinutelyWeatherResponse]
    var hourly: [HourlyWeatherResponse]
    var daily: [DailyWeatherResponse]
    var alerts: [AlertResponse]?

    struct CoordinateResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
    
    struct CurrentWeatherResponse: Decodable {
        var dt: Int
        var sunrise: Int
        var sunset: Int
        var temp: Double
        var feels_like: Double
        var pressure: Int
        var humidity: Int
        var dew_point: Double
        var uvi: Double
        var clouds: Int
        var visibility: Int
        var wind_speed: Double
        var wind_deg: Int
        var wind_gust: Double
        var weather: [WeatherResponse]
    }

    struct MinutelyWeatherResponse: Decodable {
        var dt: Int
        var precipitation: Double
    }

    struct HourlyWeatherResponse: Decodable {
        var dt: Int
        var temp: Double
        var feels_like: Double
        var pressure: Int
        var humidity: Int
        var dew_point: Double
        var uvi: Double
        var clouds: Int
        var visibility: Int
        var wind_speed: Double
        var wind_deg: Int
        var wind_gust: Double
        var weather: [WeatherResponse]
        var pop: Double
    }

    struct DailyWeatherResponse: Decodable {
        var dt: Int
        var sunrise: Int
        var sunset: Int
        var moonrise: Int
        var moonset: Int
        var moon_phase: Double
        var summary: String
        var temp: TempResponse
        var feels_like: FeelsLikeResponse
        var pressure: Int
        var humidity: Int
        var dew_point: Double
        var wind_speed: Double
        var wind_deg: Int
        var wind_gust: Double
        var weather: [WeatherResponse]
        var clouds: Int
        var pop: Double
        var rain: Double?
        var uvi: Double

        struct TempResponse: Decodable {
            var day: Double
            var min: Double
            var max: Double
            var night: Double
            var eve: Double
            var morn: Double
        }

        struct FeelsLikeResponse: Decodable {
            var day: Double
            var night: Double
            var eve: Double
            var morn: Double
        }
    }

    struct AlertResponse: Decodable {
        var sender_name: String
        var event: String
        var start: Int
        var end: Int
        var description: String
        var tags: [String]
    }
}

extension ResponseBody.MainResponse{
    var feelslike: Double {return feels_like}
    var tempMin: Double {return temp_min }
    var tempMax: Double {return temp_max}
}
