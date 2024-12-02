//
//  LocationsListViewModel.swift
//  Places
//
//  Created by Said Rehouni on 28/11/24.
//

import Foundation

class LocationsListViewModel: ObservableObject {
    enum State {
        case loading
        case success([Location])
        case failure(String)
    }
    
    private var locations: [Location] = []
    @Published var shouldPresentModalErrorAlert: Bool = false
    @Published var state: State = .loading
    
    private let getRecommentedLocations: GetRecommendedLocationsUseCaseType
    
    init(getRecommentedLocations: GetRecommendedLocationsUseCaseType) {
        self.getRecommentedLocations = getRecommentedLocations
    }
    
    @MainActor
    func onAppear() {
        Task {
            do {
                let locations = try await getRecommentedLocations()
                self.locations = locations
                state = .success(locations)
            } catch {
                state = .failure("Something went wrong")
            }
        }
    }
    
    func addLocation(name: String, latitude: String, longitude: String) {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
            
        guard let lat = formatter.number(from: latitude)?.doubleValue,
              let long = formatter.number(from: longitude)?.doubleValue,
              let location = try? Location.create(name: name,
                                                  latitude: lat,
                                                  longitude: long)
        else {
            shouldPresentModalErrorAlert = true
            return
        }
        locations.append(location)
        state = .success(locations)
    }
    
    func urlForLocation(location: Location) -> URL? {
        URL(string: "wikipedia://places?latitude=\(location.latitude)&longitude=\(location.longitude)")
    }
}

extension Location: Identifiable {
    public var id: String { "\(self.latitude) , \(self.longitude)" }
}
