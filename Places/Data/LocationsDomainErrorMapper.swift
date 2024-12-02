//
//  LocationsDomainErrorMapper.swift
//  Places
//
//  Created by Said Rehouni on 1/12/24.
//

import Foundation

class LocationsDomainErrorMapper: LocationsDomainErrorMapperType {
    func map(_ error: any Error) -> LocationsDomainError {
        guard let error = error as? HTTPClientError else {
            return .generic
        }
        // Since we don't have more domain errors defined
        // we return the generic error the same case as
        // if we were to map a non HTTPClientError
        return .generic
    }
}
