//
//  HTTPClientMock.swift
//  PlacesTests
//
//  Created by Said Rehouni on 1/12/24.
//

import Foundation
@testable import Places

class HTTPClientMock: HTTPClient {
    private let result: Result<Data, HTTPClientError>
    var capturedEndpoint: (Endpoint, String)?
    
    init(result: Result<Data, HTTPClientError>) {
        self.result = result
    }
    
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        capturedEndpoint = (endpoint, baseUrl)
        return result
    }
}
