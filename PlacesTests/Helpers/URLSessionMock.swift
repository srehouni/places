//
//  URLSessionMock.swift
//  PlacesTests
//
//  Created by Said Rehouni on 27/11/24.
//

import Foundation
@testable import Places

class URLSessionMock: URLSessionType {
    private let result: Result<(Data, URLResponseType), Error>
    
    init(result: Result<(Data, URLResponseType), Error>) {
        self.result = result
    }
    
    func data(url: URL) async throws -> (Data, URLResponseType) {
        switch result {
            case .success(let value):
                return value
            case .failure(let error):
                throw error
        }
    }
}

class HTTPURLResponseMock: URLResponseType {
    let statusCode: Int
    
    init(statusCode: Int) {
        self.statusCode = statusCode
    }
}
