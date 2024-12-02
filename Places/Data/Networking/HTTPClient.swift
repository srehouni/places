//
//  HTTPClient.swift
//  Places
//
//  Created by Said Rehouni on 27/11/24.
//

import Foundation

protocol HTTPClient {
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError>
}
