//
//  URLSessionType.swift
//  Places
//
//  Created by Said Rehouni on 27/11/24.
//

import Foundation

protocol URLSessionType: AnyObject {
    func data(url: URL) async throws -> (Data, URLResponseType)
}

protocol URLResponseType {
    var statusCode: Int { get }
}

extension URLSession: URLSessionType {
    func data(url: URL) async throws -> (Data, any URLResponseType) {
        let result = try await data(from: url)
        
        guard let response = result.1 as? HTTPURLResponse else {
            throw HTTPClientError.responseError
        }
        
        return (result.0, response)
    }
}

extension HTTPURLResponse: URLResponseType {}
