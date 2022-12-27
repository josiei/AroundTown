//
//  Venue.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 12/27/22.
//

import Foundation

struct Venue: Decodable {
    var location: [Location]?
    var name: String?
    var photos: [Photo]?
    var price: Int?
    var rating: Double?
    var tel: String?
    var website: String?
}
