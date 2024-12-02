//
//  HTTPClientError.swift
//  Places
//
//  Created by Said Rehouni on 27/11/24.
//

import Foundation

enum HTTPClientError: Error {
    case clientError
    case serverError
    case badURL
    case responseError
    case generic
}
