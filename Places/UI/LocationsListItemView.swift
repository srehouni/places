//
//  LocationsListItemView.swift
//  Places
//
//  Created by Said Rehouni on 28/11/24.
//

import SwiftUI

struct LocationsListItemView: View {
    let name: String?
    let latitude: Double
    private var _latitude: String { "lat: \(latitude)"}
    let longitude: Double
    private var _longitude: String { "long: \(longitude)"}
    
    var body: some View {
        HStack {
            
            if let name = name {
                VStack(alignment: .leading) {
                    Text(name)
                    HStack {
                        Text(_latitude).font(.caption)
                        Text(_longitude).font(.caption)
                    }
                }
            } else {
                VStack(alignment: .leading) {
                    Text(_latitude).font(.callout)
                    Text(_longitude).font(.callout)
                }
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}
