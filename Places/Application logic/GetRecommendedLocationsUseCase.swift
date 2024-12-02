//
//  GetRecommendedLocationsUseCase.swift
//  Places
//
//  Created by Said Rehouni on 28/11/24.
//

import Foundation

protocol GetRecommendedLocationsUseCaseType {
    func callAsFunction() async throws -> [Location]
}

class GetRecommendedLocationsUseCase: GetRecommendedLocationsUseCaseType {
    let repository: LocationsRepositoryType
    
    init(repository: LocationsRepositoryType) {
        self.repository = repository
    }
    
    func callAsFunction() async throws(LocationsDomainError) -> [Location] {
        try await repository.fetchRecommendedLocations()
    }
}
