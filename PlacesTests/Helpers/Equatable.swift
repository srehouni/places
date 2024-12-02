//
//  Equatable.swift
//  PlacesTests
//
//  Created by Said Rehouni on 1/12/24.
//

import Foundation
@testable import Places

extension Location: @retroactive Equatable {
    public static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.name == rhs.name
        && lhs.latitude == rhs.latitude
        && lhs.longitude == rhs.longitude
    }
    
    static func makeLocationsStub() -> [Location] {
        [
            try! Location.create(name: "Location 1", latitude: 48.1388, longitude: 11.5),
            try! Location.create(name: "Location 2", latitude: 48.1388, longitude: 11.5700)
        ]
    }
}

extension LocationsListViewModel.State: @retroactive Equatable {
    public static func == (lhs: LocationsListViewModel.State, rhs: LocationsListViewModel.State) -> Bool {
        switch (lhs, rhs) {
            case (.success, .success), (.failure, .failure),(.loading, .loading):
                return true
            default:
                return false
        }
    }
}
