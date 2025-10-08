//
//  WeatherRow.swift
//  Weather
//
//  Created by Tanmay Avinash Dabhade on 7/16/24.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        
        HStack(spacing: 20){
            Image(systemName: logo)
                .font(.title)
                .frame(width: 50, height: 50)
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                .cornerRadius(50)
            
            VStack(alignment: .leading, spacing: 8){
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title2)
            }
        }
        
    }
}

struct WeatherRow_Previews:  PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels Like", value: "8º")
    }
}
