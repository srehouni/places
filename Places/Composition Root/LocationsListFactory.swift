//
//  LocationsListFactory.swift
//  Places
//
//  Created by Said Rehouni on 28/11/24.
//

import Foundation
import UIKit

class LocationsListFactory {
    static func makeLocationsFeature() -> LocationsContainerView {
        LocationsContainerView(viewModel: makeViewModel())
    }
    
    private static func makeViewModel() -> LocationsListViewModel {
        LocationsListViewModel(getRecommentedLocations: makeGetRecommendedLocationsUseCase())
    }
    
    private static func makeGetRecommendedLocationsUseCase() -> GetRecommendedLocationsUseCaseType {
        GetRecommendedLocationsUseCase(repository: makeRemoteLocationsRespository())
    }
    
    private static func makeRemoteLocationsRespository() -> LocationsRepositoryType {
        RemoteLocationsRepository(httpClient: makeHttpClient(),
                                  errorMapper: LocationsDomainErrorMapper())
    }
    
    private static func makeHttpClient() -> HTTPClient {
        URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                             errorResolver: URLSessionErrorResolver())
    }
}
