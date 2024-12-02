//
//  RemoteLocationsRepository.swift
//  Places
//
//  Created by Said Rehouni on 1/12/24.
//

import Foundation

class RemoteLocationsRepository: LocationsRepositoryType {
    let httpClient: HTTPClient
    let errorMapper: LocationsDomainErrorMapper
    
    init(httpClient: HTTPClient, errorMapper: LocationsDomainErrorMapper) {
        self.httpClient = httpClient
        self.errorMapper = errorMapper
    }
    
    func fetchRecommendedLocations() async throws(LocationsDomainError) -> [Location] {
        let endPoint = Endpoint(path: "abnamrocoesd/assignment-ios/main/locations.json",
                                queryParameters: [:],
                                method: .get)
        
        let result = await httpClient.makeRequest(endpoint: endPoint, baseUrl: "https://raw.githubusercontent.com/")
        
        return try handleResult(result)
    }
    
    private func handleResult(_ result: Result<Data, HTTPClientError>) throws(LocationsDomainError) -> [Location] {
        guard let data = try? result.get(),
              let locations = try? JSONDecoder().decode(LocationResponseDTO.self, from: data).locations else {
            
            guard case .failure(let error) = result else {
                throw errorMapper.map(HTTPClientError.generic)
            }
            
            throw errorMapper.map(error)
        }
        
        return locations.compactMap { $0.toDomain() }
    }
}
