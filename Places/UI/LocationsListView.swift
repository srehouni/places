//
//  LocationsListView.swift
//  Places
//
//  Created by Said Rehouni on 28/11/24.
//

import SwiftUI

struct LocationsListView: View {
    let locations: [Location]
    let didTapLocation: (Location) -> Void
    
    var body: some View {
        if locations.isEmpty {
            Text("There are no locations yet.")
        } else {
            List(locations, id: \.id) { location in
                Button {
                    didTapLocation(location)
                } label: {
                    LocationsListItemView(name: location.name,
                                          latitude: location.latitude,
                                          longitude: location.longitude)
                }
            }.listStyle(.plain)
        }
    }
}
