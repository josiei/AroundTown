//
//  MapView.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 1/8/23.
//

import UIKit
import MapKit

class MapView: UIView {
    private let mapView = MKMapView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupMapView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMapView()
    }
    
    private func setupMapView(){
        self.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setRegion(region: MKCoordinateRegion, animated: Bool){
        mapView.setRegion(region, animated: animated)
    }
    
    func addAnnotation(annotation: MKAnnotation){
        mapView.addAnnotation(annotation)
    }
    
}
