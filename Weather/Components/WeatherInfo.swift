//
//  WeatherInfo.swift
//  Weather
//
//  Created by Tanmay Avinash Dabhade on 7/16/24.
//

import SwiftUI

struct WeatherInfo: View {
    var weather_description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            switch weather_description {
            case "Clear":
                Image(systemName: "sun.max.fill")
                    .font(.system(size: 40))
            case "Rain":
                Image(systemName: "cloud.rain.fill")
                    .font(.system(size: 40))
            case "Thunderstorm":
                Image(systemName: "cloud.bolt.rain.fill")
                    .font(.system(size: 40))
            case "Drizzle":
                Image(systemName: "cloud.drizzle.fill")
                    .font(.system(size: 40))
            case "Snow":
                Image(systemName: "cloud.snow.fill")
                    .font(.system(size: 40))
            case "Mist", "Fog":
                Image(systemName: "cloud.fog.fill")
                    .font(.system(size: 40))
            case "Smoke":
                Image(systemName: "smoke.fill")
                    .font(.system(size: 40))
            case "Haze":
                Image(systemName: "sun.haze.fill")
                    .font(.system(size: 40))
            case "Dust", "Sand", "Ash":
                Image(systemName: "sun.dust.fill")
                    .font(.system(size: 40))
            case "Squall":
                Image(systemName: "wind.snow")
                    .font(.system(size: 40))
            case "Tornado":
                Image(systemName: "tornado")
                    .font(.system(size: 40))
            case "Clouds":
                Image(systemName: "cloud.fill")
                    .font(.system(size: 40))
            default:
                Image(systemName: "questionmark")
                    .font(.system(size: 40))
            }
            
            Text(weather_description)
                .font(.system(size: 30))
        }
        .frame(width: 100, alignment: .leading)
        .padding(.leading, 20)
        Spacer()
    }
}

struct WeatherInfo_Previews:  PreviewProvider {
    static var previews: some View {
        WeatherInfo(weather_description: "Clear")
    }
}
