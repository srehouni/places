//
//  Endpoint.swift
//  Places
//
//  Created by Said Rehouni on 27/11/24.
//

import Foundation

struct Endpoint {
    let path: String
    let queryParameters: [String : Any]
    let method: HTTPMethod
}
