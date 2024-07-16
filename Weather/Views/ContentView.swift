//
//  ContentView.swift
//  Weather
//
//  Created by Tanmay Avinash Dabhade on 7/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    //We added state object property wrapper so that the view is notified whenever the locations in the Location Manager are updated.
    var weatherManager = WeatherManager()
    
    @State var weather: ResponseBody?
    //Making optional to handle errors.
    
    var body: some View {
        VStack {
            
            
            //we are using an if statement because the location is optional, if we dont have a location then we will not dislay the coordinates
            if let location  = locationManager.location{
                if let weather = weather {
                   WeatherView(weather: weather)
                    
                } else {
                    //On loading view we add a task modifier, it adds an async tast to perform when the view appears.
                    LoadingView()
                        .task {
                        do{
                            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            
                        }catch{
                            print("Error getting weather: \(error)")
                        }
                    }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView().environmentObject(locationManager)
                }
            }
                
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.345))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}


