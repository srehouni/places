//
//  GetRecommendedLocationsUseCaseMock.swift
//  PlacesTests
//
//  Created by Said Rehouni on 1/12/24.
//

import Foundation
@testable import Places

class GetRecommendedLocationsUseCaseMock: GetRecommendedLocationsUseCaseType {
    private let result: Result<[Location], Error>
    
    init(result: Result<[Location], Error>) {
        self.result = result
    }
    
    func callAsFunction() async throws -> [Location] {
        switch result {
        case .success(let locations):
            return locations
        case .failure(let error):
            throw error
        }
    }
}
