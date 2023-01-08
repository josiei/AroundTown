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
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpContainerView(view: view)
        setupHeaderImage(view: containerView)
        
        label.text = "test"
        containerView.addArrangedSubview(label)
        
        //Set background color
        view.backgroundColor = .white

    }
    
    func setUpContainerView(view: UIView){
        //Add to view hierachy
        view.addSubview(containerView)
        
        //Set the direction
        containerView.axis = .vertical
        
        //Set to false to take advantage of auto-layout
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        //Pin view to all corners of the screen
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
    }
    
    func setupHeaderImage(view: UIStackView){
        
        //TODO: Guard against no photos
        
        let headerImageView = UIImageView()
       
        //Grab the first photo
        let mainPhoto = venueToDisplay!.photos![0]
        
        //Form URL String
        let prefix = mainPhoto.prefix!
        let suffix = mainPhoto.suffix!
        let imageUrl = prefix + "original" + suffix
        
        let imageData = ImageCache.getImage(url: imageUrl)
        headerImageView.image = UIImage(data: imageData!)
        print(ImageCache.cache)
        
        view.addArrangedSubview(headerImageView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
