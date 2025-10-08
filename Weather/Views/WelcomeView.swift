//
//  WelcomeView.swift
//  Weather
//
//  Created by Tanmay Avinash Dabhade on 7/16/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack{
            
            VStack{
                Text("Welcome to Weather App")
                    .bold().font(.title)
                
                Text("Share your current location to get weather data in your area.")

                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            //needs CoreLocationUI
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .foregroundColor(.white)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}
