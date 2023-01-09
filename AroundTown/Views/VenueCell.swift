//
//  TableViewCell.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 1/3/23.
//

import UIKit

class VenueCell: UITableViewCell {
    
    var venueName = UILabel()
    var venueImageView = UIImageView()
    var venueToDisplay:Venue?
    
    func displayVenue(_ venue: Venue){
        
        //Clean up cell before reuse
        venueImageView.image = nil
        venueImageView.alpha = 0
        venueName.text = ""
        venueName.alpha = 0
        
        //Save reference to venue
        venueToDisplay = venue
        
        //Modify Cell properties
        contentView.backgroundColor = .white
        backgroundColor = .clear
        
        //Set up the Venue name label
        venueName.text = venueToDisplay!.name
        venueName.textColor = .black
        venueName.translatesAutoresizingMaskIntoConstraints = false
        venueName.font = UIFont(name: "SuisseIntlTrial-Bold", size: 20)
        venueName.numberOfLines = 0
        
        //Set up image
        venueImageView.translatesAutoresizingMaskIntoConstraints = false
        venueImageView.contentMode = .scaleAspectFill
        venueImageView.layer.masksToBounds = true
        venueImageView.layer.cornerRadius = 2
        
        //Animate label appearance
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {

            self.venueName.alpha = 1
            
        }, completion: nil)
            
        //Download and display image
        self.getImage()

        self.setupConstraints()
        
    }
    
    private func setupConstraints(){
        contentView.addSubview(venueImageView)
        contentView.addSubview(venueName)
        
        venueImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        venueImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        venueImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        venueImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        venueName.topAnchor.constraint(equalTo: venueImageView.bottomAnchor, constant: 8).isActive = true
        venueName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        venueName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
    }
    
    private func getImage(){
        
        //Check that there are photos available
        guard (venueToDisplay!.photos?.count ?? 0) > 0  else {
            return
        }
        
        //Grab the first photo
        let mainPhoto = venueToDisplay!.photos![0]
        
        //Form URL String
        let prefix = mainPhoto.prefix!
        let suffix = mainPhoto.suffix!
        let urlString = prefix + "original" + suffix
        
        
        //TODO: check cache to see if image has already been loaded 
        
        //Create the url
        let url = URL(string: urlString)
        
        //Check that the url isnt nil
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        //Get a URLSession
        let session = URLSession.shared
        
        //Create data-task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            //If there are no errors and the data exists
            if error == nil && data != nil {
                
                //Check that saved url matches the article cell set to display
                if self.venueToDisplay!.photos![0].prefix == prefix {
                
                    DispatchQueue.main.async {
                        
                        self.venueImageView.image = UIImage(data: data!)
                        
                        //Save image data to cache
                        ImageCache.saveImage(url: urlString, imageData: data!)
                        
                        //Animate the image into view after loading
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.venueImageView.alpha = 1
                            
                        }, completion: nil)
                        
                        
                    }
                }
                
            }
        }
        
        dataTask.resume()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Set the content view frame
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left:20, bottom: 10, right: 20))
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.clear
        
        self.selectedBackgroundView = selectedBackgroundView
    }

}
