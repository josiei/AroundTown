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
    let venueTable = UITableView()
    var suisseFont = UIFont(name: "SuisseIntlTrial-Bold", size: 25)
    let background = UIImage(named: "blobs")
    
    //UIColor for #be9cf3
    let accentColor = UIColor(red: 0.75, green: 0.61, blue: 0.95, alpha: 1.00)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign view controller as delegate to VenueModel
        venueModel.delegate = self
        
        //Get the venues from the venue model
        venueModel.getVenues()
        
        //Set up layout
        setUpParentView()
        setUpSubViewsProportionally(view: containerView)
        
        //Assign VC as delegate and datasource for table view
        venueTable.delegate = self
        venueTable.dataSource = self
        
        //Set navigation controller background to white
        navigationController?.navigationBar.barTintColor = .white
        
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
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = background
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
        
        
    }
    
    func setUpHeader(view: UIStackView){
        //Create container
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 5
        
        //Set up Labels
        let findVenuesLabel = UILabel()
        findVenuesLabel.text = "Find Venues in"
        findVenuesLabel.font = suisseFont
        
        //Add stroke to label
        let strokeAttributes: [NSAttributedString.Key:Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: accentColor,
            .strokeWidth: -4.0,
            .font: UIFont(name: "SuisseIntlTrial-Bold", size: 35)!
        ]
            
        locationLabel.attributedText = NSAttributedString(string: locationModel.userLocation, attributes: strokeAttributes)
        
        
        
        //Add label to vertical stack
        verticalStack.addArrangedSubview(findVenuesLabel)
        verticalStack.addArrangedSubview(locationLabel)
        
        //Add stack to parent view
        view.addArrangedSubview(verticalStack)
        
        
    }
    
    func createCategoryRow(view: UIStackView){
        //Create horizontal stack
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 1
        horizontalStack.distribution = .equalSpacing
        
        //Place buttons in a horizontal stack
        let allButton = createBaseButton(view: horizontalStack, imageName: "all-button")
        let musicButton = createBaseButton(view: horizontalStack, imageName: "music-button")
        let foodButton = createBaseButton(view: horizontalStack, imageName: "food-button")
        let outdoorButton = createBaseButton(view: horizontalStack, imageName: "outdoor-button")
        let barButton = createBaseButton(view: horizontalStack, imageName: "bar-button")
        
        //Set tags for buttons
        allButton.tag = 1
        musicButton.tag = 2
        foodButton.tag = 3
        outdoorButton.tag = 4
        barButton.tag = 5
        
        view.addArrangedSubview(horizontalStack)
        
    }
    
    func setUpCategorySection(view: UIStackView){
        //Create vertical stack
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 15
        
        //Customize label
        let browseLabel = UILabel()
        browseLabel.text = "Browse By Category"
        browseLabel.font = suisseFont
        
        verticalStack.addArrangedSubview(browseLabel)
        createCategoryRow(view: verticalStack)
        
        view.addArrangedSubview(verticalStack)
        
        
    }
    
    func createBaseButton(view: UIStackView, imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        
        //Set button's frame size and position
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 90)
        
        //Get image using imageName
        let image = UIImage(named: imageName)
        let imageHighlighted = UIImage(named: "\(imageName)-highlighted")
        
        //Set images for buttons
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(imageHighlighted, for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        
        view.addArrangedSubview(button)
        
        return button
    }
    
    func setUpVenueSection(view: UIStackView){
        //Create vertical stack
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 10
        
        //Customize label
        let venueLabel = UILabel()
        venueLabel.text = "Places For You"
        venueLabel.font = suisseFont
        
        //Set up Table View
        venueTable.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
        venueTable.backgroundColor = .clear
        venueTable.rowHeight = 250
        venueTable.separatorStyle = .none
        
        //Register venue cell with reuseable identifier
        venueTable.register(VenueCell.self, forCellReuseIdentifier: "VenueCell")
        
        verticalStack.addArrangedSubview(venueLabel)
        verticalStack.addArrangedSubview(venueTable)
        
        view.addArrangedSubview(verticalStack)
        
    }

    func setUpSubViewsProportionally(view: UIStackView) {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 20
        
        //Add content sections to stack
        setUpHeader(view: verticalStack)
        setUpCategorySection(view: verticalStack)
        setUpVenueSection(view: verticalStack)
        
        view.addArrangedSubview(verticalStack)
        
        //Add padding
        verticalStack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        verticalStack.isLayoutMarginsRelativeArrangement = true

    }
    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a reuseable cell
        let cell = venueTable.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! VenueCell
        
        //Get the venue for the specified cell
        let venue = self.venues[indexPath.row]
        
        //Customize the cell 
        cell.displayVenue(venue)
        
        return cell
    }
        
    
}

extension ViewController: VenueModelProtocol {
    
    //MARK: – Venue Model Protocol Methods
    
    func venuesRetrieved(_ venues: [Venue]) {
        self.venues = venues
        
        //Refresh the table, as the venues are initially set to empty
        venueTable.reloadData()
        
    }
        
}
