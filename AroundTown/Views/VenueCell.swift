//
//  TableViewCell.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 1/3/23.
//

import UIKit

class VenueCell: UITableViewCell {
    
    var venueName = UILabel()
    var venueToDisplay:Venue?
    
    func displayVenue(_ venue: Venue){
        
        //Save reference to venue
        venueToDisplay = venue
        
        //Set the Venue name
        venueName.text = venueToDisplay!.name
        print(venueName.text!)
        venueName.textColor = .black
        
        //Add to cell's content view
        contentView.addSubview(venueName)
        venueName.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
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
