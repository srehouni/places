//
//  Location.swift
//  Places
//
//  Created by Said Rehouni on 28/11/24.
//

import Foundation

struct Location {
    let name: String?
    let latitude: Double
    let longitude: Double
    
    private init(name: String?, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    static func create(name: String?, latitude: Double, longitude: Double) throws(LocationsDomainError) -> Location {
        guard validateCoordinates(latitude: latitude, longitude: longitude) else {
            throw .invalidCoordinates
        }
        
        return Location(name: name, latitude: latitude, longitude: longitude)
    }
    
    private static func validateCoordinates(latitude: Double, longitude: Double) -> Bool {
        let isValidLatitude = latitude >= -90 && latitude <= 90
        let isValidLongitude = longitude >= -180 && longitude <= 180
        return isValidLatitude && isValidLongitude
    }
}
