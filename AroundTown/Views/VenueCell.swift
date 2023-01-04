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
        
        //Save reference to venue
        venueToDisplay = venue
        
        //Set the Venue name
        venueName.text = venueToDisplay!.name
        print(venueName.text!)
        venueName.textColor = .black
        
        //Add to cell's content view
        //contentView.addSubview(venueName)
        
        
        //Download and display image
        
        //Check that there are photos available
        guard (venueToDisplay!.photos?.count ?? 0) > 0  else {
            return
        }
        
        //Grab the first photo
        let mainPhoto = venueToDisplay!.photos![0]
        
        //Form URL String
        let urlString = mainPhoto.prefix! + "original" + mainPhoto.suffix!
        
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
                
                DispatchQueue.main.async {
                    
                    self.venueImageView.image = UIImage(data: data!)
                    
                }
                
                
            }
        }
        
        dataTask.resume()
        
        //Add image and name to the view
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        
        verticalStack.addArrangedSubview(venueImageView)
        verticalStack.addArrangedSubview(venueName)
        
        verticalStack.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
//        venueName.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        
        contentView.addSubview(verticalStack)
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
