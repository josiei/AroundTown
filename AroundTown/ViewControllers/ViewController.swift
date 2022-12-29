//
//  ViewController.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 12/26/22.
//

import UIKit

class ViewController: UIViewController {

    var locationModel = LocationModel()
    var venueModel = VenueModel()
    var venues = [Venue]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign view controller as delegate to VenueModel
        venueModel.delegate = self
        
        //Get the venues from the venue model
        venueModel.getVenues()
        
        //Set the default text
        //locationLabel.text = locationModel.userLocation
        
        //Subscribe VC to notification when LocationModel changes userLocation property
//        NotificationCenter.default.addObserver(self, selector: #selector(locationChanged(_:)), name: NSNotification.Name("LocationChanged"), object: nil)

        
    }
    
    //Change the locationLabel text when userLocation gets updated
//    @objc func locationChanged(_ notification: Notification){
//        locationLabel.text = locationModel.userLocation
//    }


}

extension ViewController: VenueModelProtocol {
    
    //MARK: – Venue Model Protocol Methods
    
    func venuesRetrieved(_ venues: [Venue]) {
        self.venues = venues
        
    }
    
    
}
