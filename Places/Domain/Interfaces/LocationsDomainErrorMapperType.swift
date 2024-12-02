//
//  LocationsDomainErrorMapperType.swift
//  Places
//
//  Created by Said Rehouni on 1/12/24.
//

import Foundation

protocol LocationsDomainErrorMapperType {
    func map(_ error: Error) -> LocationsDomainError
}
