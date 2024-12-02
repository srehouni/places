//
//  PlacesApp.swift
//  Places
//
//  Created by Said Rehouni on 27/11/24.
//

import SwiftUI

@main
struct PlacesApp: App {
    var body: some Scene {
        WindowGroup {
            LocationsListFactory.makeLocationsFeature()
        }
    }
}
