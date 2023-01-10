//
//  DetailViewController.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 1/7/23.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController {
    
    var venueToDisplay:Venue? = nil
    let containerView = UIStackView()
    let background = UIImage(named: "lily")
    let mapView = MapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpContainerView(view: view)
        setupHeaderImage(view: containerView)
        setupDetailRows(view: containerView)
        containerView.addArrangedSubview(mapView)
        getCoordinatesOfVenue()
        
        //Set background color
        view.backgroundColor = .white

    }
    
    @objc func handleLabelTap() {
        
        let webviewVC = WebViewController()
        
        //Pass webviewVC the website url
        webviewVC.websiteUrl = venueToDisplay?.website
        
        //Add to the navigation controller
        navigationController?.pushViewController(webviewVC, animated: true)
        
    }
    
    private func getCoordinatesOfVenue(){
        
        let address = "\(venueToDisplay?.location?.address ?? "") \(venueToDisplay?.location?.locality ?? ""), \(venueToDisplay?.location?.region ?? ""))"
        let geocoder = CLGeocoder()
        var lat: Double?
        var long: Double?
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            
            //If there are errors, or no items in placemarks exit
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("no placemarks to display")
                return
            }
            
            guard let location = placemark.location else {
                return
            }
            
            lat = location.coordinate.latitude
            long = location.coordinate.longitude
            
            self.setupMap(lat: lat!, long: long!)
            
            
        }
        
    }
    
    private func setupMap(lat: Double, long: Double){
        
        //Set region of map
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region: region, animated: true)
        
        //Set pin
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation: annotation)
        
    }
    
    private func setUpContainerView(view: UIView){
        //Add to view hierachy
        view.addSubview(containerView)
        
        //Set the direction
        containerView.axis = .vertical
        containerView.spacing = 25
        
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
    
    private func setupVenueName(view: UIStackView){
        
        let venueName = UILabel()
        view.addArrangedSubview(venueName)
        
        venueName.text = venueToDisplay?.name
        venueName.font = Fonts.suisse30
        venueName.numberOfLines = 0
        
    }
    
    private func setupHeaderImage(view: UIStackView){
        
        //TODO: Guard against no photos
        
        let headerImageView = UIImageView()
        view.addArrangedSubview(headerImageView)
       
        //Grab the first photo
        let mainPhoto = venueToDisplay!.photos![0]
        
        //Form URL String
        let prefix = mainPhoto.prefix!
        let suffix = mainPhoto.suffix!
        let imageUrl = prefix + "original" + suffix
        
        //Get image from cache and set it
        let imageData = ImageCache.getImage(url: imageUrl)
        headerImageView.image = UIImage(data: imageData!)
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        
        //Scale image to 30% of view
        headerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        
    }
    
    private func setupIcon(imageName: String, button: UIButton){
        
        //Add an image for the button
        let image = UIImage(named: imageName)
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.isUserInteractionEnabled = false
        
    }
    
    private func setupAddressRow(view: UIStackView){
        
        let address = UILabel()
        let button = UIButton()
        let horizontalRow = UIStackView()
        
        view.addArrangedSubview(horizontalRow)

        //Set up address label
        let formattedAddress = """
        \(venueToDisplay?.location?.address ?? "In the city of")
        \(venueToDisplay?.location?.locality ?? "") \(venueToDisplay?.location?.region ?? "")
        """
        address.text = formattedAddress
        address.font = Fonts.suisse20
        address.numberOfLines = 0
        
        horizontalRow.alignment = .top
        
        setupIcon(imageName: "geo-button", button: button)
        setupHorizontalRow(horizontalRow: horizontalRow, button: button, label: address, view: view)
                
    }
    
    
    private func setupWebsiteRow(view: UIStackView){
        
        let horizontalRow = UIStackView()
        view.addArrangedSubview(horizontalRow)
        
        let websiteLabel = UILabel()
        let button = UIButton()
                
        setupHorizontalRow(horizontalRow: horizontalRow, button: button, label: websiteLabel, view: view)
        setupIcon(imageName: "navigation-button", button: button)
        
        //Check if there is a website to display
        if venueToDisplay?.website == nil {
            websiteLabel.text = "No website available"
        } else {
            
            // Format label with underline
            let attributedText = NSMutableAttributedString(string: "Visit our website")
            attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: _NSRange(location: 0, length: attributedText.length))
            websiteLabel.attributedText = attributedText
            
            //Add tapRecognizer to label
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap))
            websiteLabel.addGestureRecognizer(tapGestureRecognizer)
            websiteLabel.isUserInteractionEnabled = true
            
        }
        
        websiteLabel.font = Fonts.suisse20
        
        //Center label with icon
        websiteLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
    }
    
    private func setupTelephoneRow(view: UIStackView){
        
        let horizontalRow = UIStackView()
        view.addArrangedSubview(horizontalRow)
        
        let telephoneLabel = UILabel()
        let button = UIButton()
        
        if venueToDisplay?.tel == nil {
            telephoneLabel.text = "Not available"
        } else {
            telephoneLabel.text = venueToDisplay?.tel
        }
        
        telephoneLabel.font = Fonts.suisse20
        
        setupHorizontalRow(horizontalRow: horizontalRow, button: button, label: telephoneLabel, view: view)
        setupIcon(imageName: "phone-button", button: button)
        
                
    }
    
    private func setupHorizontalRow(horizontalRow: UIStackView, button: UIButton, label: UILabel, view: UIStackView){
        
        //Add button and label to a horizontal row
        horizontalRow.axis = .horizontal
        horizontalRow.addArrangedSubview(button)
        horizontalRow.addArrangedSubview(label)
        horizontalRow.spacing = 8
        
        //Set the width of the horizontal stack
        horizontalRow.translatesAutoresizingMaskIntoConstraints = false
        let width = horizontalRow.widthAnchor.constraint(equalTo: view.widthAnchor)
        width.constant -= Layout.detailRowOffset
        width.isActive = true
        
        
    }
    
    private func setupDetailRows(view: UIStackView){
        let verticalStack = UIStackView()
        view.addArrangedSubview(verticalStack)
        
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillProportionally
        verticalStack.spacing = 10
        
        //Set the width of the vertical stack
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        //Add margin spacing 
        verticalStack.layoutMargins = UIEdgeInsets(top: 0, left: Layout.detailRowOffset, bottom: 0, right: 0)
        verticalStack.isLayoutMarginsRelativeArrangement = true
        
        setupVenueName(view: verticalStack)
        setupAddressRow(view: verticalStack)
        setupWebsiteRow(view: verticalStack)
        setupTelephoneRow(view: verticalStack)
        
        
    }
    
    

}
