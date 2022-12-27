//
//  LocationModel.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 12/26/22.
//

import Foundation
import CoreLocation

class LocationModel: NSObject, CLLocationManagerDelegate {
    
    
    private let locationManager = CLLocationManager()
    var userLocation = "Oakland, CA" //Setting a default value
    
    override init(){
        super.init()
        
        //Set location model as delegate of location manager
        locationManager.delegate = self
        
        //Request Permission from the user
        locationManager.requestWhenInUseAuthorization()
    }
    
    //MARK – Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            //We have permission, so geolocate the user
            locationManager.startUpdatingLocation()
        } else if locationManager.authorizationStatus == .denied {
            
            //TODO: Case where user denies location services
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geoCoder = CLGeocoder()
        
        guard locations.first != nil else {
            return
        }
        
        // Get the location of the user
        let userCLLocation = locations.first!
        
        //Reverse the CCLocation object to save as a string for UI display
        geoCoder.reverseGeocodeLocation(userCLLocation) { placemarks, error in
            
            //If there are errors, or no items in placemarks exit
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("no placemarks to display")
                return
            }
            
            //Get the city and state names from the placemark, or set it back to default value
            
            let city = placemark.locality ?? "Oakland"
            let state = placemark.administrativeArea ?? "CA"
            
            DispatchQueue.main.async {
                
                //Save the user location as a formatted string
                self.userLocation = "\(city), \(state)"
                
            }
            
        }
                
        //Stop requesting location after we get it
        locationManager.stopUpdatingLocation()
        
        
    }
    
    
}
