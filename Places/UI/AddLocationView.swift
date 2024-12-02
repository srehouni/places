//
//  AddLocationView.swift
//  Places
//
//  Created by Said Rehouni on 28/11/24.
//

import Foundation
import SwiftUI

struct AddLocationView: View {
    @State private var locationName: String = ""
    @State private var locationLatitude: String = ""
    @State private var locationLongitude: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var addLocation: (String, String, String) -> Void
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Add New Location")
                .font(.headline)
            
            TextField("Name", text: $locationName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Latitude", text: $locationLatitude)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Longitude", text: $locationLongitude)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Add") {
                addLocation(locationName, locationLatitude, locationLongitude)
                dismiss()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Button("Cancel") {
                dismiss()
            }
            .padding()
        }
    }
}
