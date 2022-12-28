//
//  VenueModel.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 12/27/22.
//

import Foundation

protocol VenueModelProtocol {
    func venuesRetrieved(_ venues: [Venue])
}

class VenueModel {
    
    var delegate:VenueModelProtocol?
    
    func getVenues(){
        
        //Make request to FourSquare API
        
        //Create the URL
        let url = URL(string: "https://api.foursquare.com/v3/places/search?query=food&fields=name%2Ctel%2Clocation%2Cwebsite%2Crating%2Cprice%2Cphotos&near=Modesto%2C%20CA")
        
        guard url != nil else {
            print("Error creating url object")
            return
        }
        
        //Create the URL Request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            
        let headers = [
          "accept": "application/json",
          "Authorization": "fsq3V7p/1uAKt+O9DzdDW9FdulmhYFMxaMQxe3UCc33n23M="
        ]
        
        //Set the request type
        request.httpMethod = "GET"
        
        //Set the headers
        request.allHTTPHeaderFields = headers
        
        //Get the URL Session
        let session = URLSession.shared
        
        //Create the dataTask
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            //Check that there are no errors and data exists
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do {
                    // Parse JSON into VenueService
                    let venueService = try decoder.decode(VenueService.self, from: data!)
                    
                    DispatchQueue.main.async {
                        
                        //Pass the venues back to ViewController
                        self.delegate?.venuesRetrieved(venueService.results!)
                    }
                    
                } catch {
                    
                    print(error, "Error parsing the JSON")
                    
                }
                
            }
        }
        
        //Start the data task
        dataTask.resume()
    }
    
}
