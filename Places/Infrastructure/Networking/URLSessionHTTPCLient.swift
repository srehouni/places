//
//  URLSessionHTTPCLient.swift
//  Places
//
//  Created by Said Rehouni on 27/11/24.
//

import Foundation

class URLSessionHTTPCLient: HTTPClient {
    private let session: URLSessionType
    private let requestMaker: URLSessionRequestMaker
    private let errorResolver: URLSessionErrorResolver
    
    init(session: URLSessionType = URLSession.shared, requestMaker: URLSessionRequestMaker, errorResolver: URLSessionErrorResolver) {
        self.session = session
        self.requestMaker = requestMaker
        self.errorResolver = errorResolver
    }
    
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        guard let url = requestMaker.url(endpoint: endpoint, baseUrl: baseUrl) else {
            return .failure(.badURL)
        }
        
        do {
            let result = try await session.data(url: url)
            let statusCode = result.1.statusCode
            
            guard statusCode == 200 else {
                return .failure(errorResolver.resolve(statusCode: statusCode))
            }
            
            return .success(result.0)
            
        } catch {
            return .failure(errorResolver.resolve(error: error))
        }
    }
}
