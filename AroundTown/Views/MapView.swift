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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
