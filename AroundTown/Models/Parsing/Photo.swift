//
//  Photo.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 12/27/22.
//

import Foundation

struct Photo: Decodable {
    var id: String?
    var createdAt: String?
    var prefix: String?
    var suffix: String?
    var width: Int?
    var height: Int?
}
