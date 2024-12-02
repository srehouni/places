//
//  LocationsContainerView.swift
//  Places
//
//  Created by Said Rehouni on 1/12/24.
//

import SwiftUI

struct LocationsContainerView: View {
    @State private var isAddingLocation: Bool = false
    @ObservedObject var viewModel: LocationsListViewModel
    @Environment(\.openURL) var openLink
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                    case .loading:
                        ProgressView().scaleEffect(2)
                            .progressViewStyle(.circular)
                    case .success(let locations):
                        LocationsListView(locations: locations) { location in
                            if let url = viewModel.urlForLocation(location: location) {
                                openLink(url)
                            }
                        }
                    case .failure(let string):
                        Text(string).font(.headline)
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
            .navigationTitle("Locations")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddingLocation = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingLocation) {
                AddLocationView() { name, latitude, longitude in
                    viewModel.addLocation(name: name, latitude: latitude, longitude: longitude)
                }
            }.alert("Error!", isPresented: $viewModel.shouldPresentModalErrorAlert) {
            } message: {
                Text("Location is not valid")
            }

        }
    }
}
