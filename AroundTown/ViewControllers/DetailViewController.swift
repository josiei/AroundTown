//
//  DetailViewController.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 1/7/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var venueToDisplay:Venue? = nil
    let containerView = UIStackView()
    let background = UIImage(named: "lily")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpContainerView(view: view)
        setupHeaderImage(view: containerView)
        setupVenueName(view: containerView)
        setupAddressRow(view: containerView)
        setupWebsiteRow(view: containerView)
        
        //Set background color
        view.backgroundColor = .white

    }
    
    func setUpContainerView(view: UIView){
        //Add to view hierachy
        view.addSubview(containerView)
        
        //Set the direction
        containerView.axis = .vertical
        containerView.spacing = 5
        
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
    
    func setupVenueName(view: UIStackView){
        let venueName = UILabel()
        venueName.text = venueToDisplay?.name
        venueName.font = UIFont(name: "SuisseIntlTrial-Bold", size: 30)
        venueName.numberOfLines = 0
        view.addArrangedSubview(venueName)
    }
    
    func setupHeaderImage(view: UIStackView){
        
        //TODO: Guard against no photos
        
        let headerImageView = UIImageView()
        view.addArrangedSubview(headerImageView)
       
        //Grab the first photo
        let mainPhoto = venueToDisplay!.photos![0]
        
        //Form URL String
        let prefix = mainPhoto.prefix!
        let suffix = mainPhoto.suffix!
        let imageUrl = prefix + "original" + suffix
        
        let imageData = ImageCache.getImage(url: imageUrl)
        headerImageView.image = UIImage(data: imageData!)
        
        //Scale image to 30% of view
        headerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
    }
    
    func setupIcon(imageName: String, button: UIButton){
        //Add an image for the button
        let image = UIImage(named: imageName)
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupAddressRow(view: UIStackView){
        
        let address = UILabel()
        let button = UIButton()
        let horizontalRow = UIStackView()
        
        horizontalRow.axis = .horizontal
        
        //Set up address label
        let formattedAddress = """
        \(venueToDisplay?.location?.address ?? "In the city of")
        \(venueToDisplay?.location?.locality ?? "") \(venueToDisplay?.location?.region ?? "")
        """
        address.text = formattedAddress
        address.font = UIFont(name: "SuisseIntlTrial-Bold", size: 20)
        address.numberOfLines = 0
        
        setupIcon(imageName: "geo-button", button: button)
        
        horizontalRow.addArrangedSubview(button)
        horizontalRow.addArrangedSubview(address)
        horizontalRow.alignment = .top
        horizontalRow.spacing = 8
        
        view.addArrangedSubview(horizontalRow)
        
    }
    
    func setupWebsiteRow(view: UIStackView){
        
        //TODO: Add guard against nil website
        
        let horizontalRow = UIStackView()
        horizontalRow.axis = .horizontal
        view.addArrangedSubview(horizontalRow)
        
        let websiteLabel = UILabel()
        let button = UIButton()
        
        horizontalRow.addArrangedSubview(button)
        horizontalRow.addArrangedSubview(websiteLabel)
        horizontalRow.spacing = 8
        
        setupIcon(imageName: "navigation-button", button: button)
        
        //Format Label
        let attributedText = NSMutableAttributedString(string: "Visit our website")
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: _NSRange(location: 0, length: attributedText.length))
        websiteLabel.attributedText = attributedText
        websiteLabel.font = UIFont(name: "SuisseIntlTrial-Bold", size: 20)
        websiteLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
    }
    

}
