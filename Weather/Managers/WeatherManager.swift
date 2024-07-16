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
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid={YOUR_API_KEY}&units=metric") else {fatalError("URL not found")}
        

        
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
    
    struct MainResponse: Decodable{
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
}

extension ResponseBody.MainResponse{
    var feelslike: Double {return feels_like}
    var tempMin: Double {return temp_min }
    var tempMax: Double {return temp_max}
}
