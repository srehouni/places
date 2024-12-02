//
//  LocationDTO.swift
//  Places
//
//  Created by Said Rehouni on 1/12/24.
//

import Foundation

struct LocationResponseDTO: Codable, Equatable {
    let locations: [LocationDTO]
}

struct LocationDTO: Codable, Equatable {
    let name: String?
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }
}

extension LocationDTO {
    func toDomain() -> Location? {
        try? Location.create(name: name, latitude: latitude, longitude: longitude)
    }
}
