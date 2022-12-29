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
    let containerView = UIStackView()
    let locationLabel = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign view controller as delegate to VenueModel
        venueModel.delegate = self
        
        //Get the venues from the venue model
        venueModel.getVenues()
        
        //Set up layout
        setUpParentView()
        setUpHeader(view: containerView)
        
        
        //Subscribe VC to notification when LocationModel changes userLocation property
        NotificationCenter.default.addObserver(self, selector: #selector(locationChanged(_:)), name: NSNotification.Name("LocationChanged"), object: nil)

        
    }
    
    //Change the locationLabel text when userLocation gets updated
    @objc func locationChanged(_ notification: Notification){
        locationLabel.text = locationModel.userLocation
    }
    
    func setUpParentView(){
        view.addSubview(containerView)
        
        //Make it vertical
        containerView.axis = .vertical
        
        //Spacing between elements
        containerView.spacing = 5
        
        //Set to false to take advantage of auto-layout
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        //Pin view to all corners of the screen
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        //Set Background Color
        containerView.backgroundColor = .white
        
    }
    
    func setUpHeader(view: UIStackView){
        //create container
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 3
        
        //add padding
        verticalStack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0)
        verticalStack.isLayoutMarginsRelativeArrangement = true
        
        //Set up Labels
        let findVenuesLabel = UILabel()
        findVenuesLabel.text = "Find Venues in"
        locationLabel.text = locationModel.userLocation
        
        //Add label to vertical stack
        verticalStack.addArrangedSubview(findVenuesLabel)
        verticalStack.addArrangedSubview(locationLabel)
        
        //add to parent view
        view.addArrangedSubview(verticalStack)
        
        
    }

    // TODO:
//    func setUpSubViewsProportionally() {
//
//    }
    


}

extension ViewController: VenueModelProtocol {
    
    //MARK: – Venue Model Protocol Methods
    
    func venuesRetrieved(_ venues: [Venue]) {
        self.venues = venues
        
    }
    
    
}
