//
//  LocationManager.swift
//  Weather
//
//  Created by Tanmay Avinash Dabhade on 7/16/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager() //Create a new instance of CLLocation manager
    
    @Published var location: CLLocationCoordinate2D? //Optional because we might not get location ex if user doesnt allow location
    @Published var isLoading = false //set to false by default
    
    override init() {
        //when class is initialised we need to call
        super.init()
        //set manager.delegate to self
        manager.delegate = self
        
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    
    //We need two more functions to make CLLocation Manager work
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //assign location variable created on line 14
        location = locations.first?.coordinate
        isLoading = false //because we got the location and the state is not loading now
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error Getting Location", error)
        isLoading = false
    }
    
}


