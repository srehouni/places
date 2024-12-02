//
//  LocationsRepositoryType.swift
//  Places
//
//  Created by Said Rehouni on 1/12/24.
//

protocol LocationsRepositoryType {
    func fetchRecommendedLocations() async throws(LocationsDomainError) -> [Location]
}
