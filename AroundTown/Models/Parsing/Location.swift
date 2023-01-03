//
//  Location.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 12/27/22.
//

import Foundation

struct Location : Decodable {
    var address: String?
    var country: String?
    var formattedAddress: String?
    var locality: String?
    var postcode: String?
    var region: String?
}
