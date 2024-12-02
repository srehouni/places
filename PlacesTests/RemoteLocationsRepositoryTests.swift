//
//  RemoteLocationsRepositoryTests.swift
//  PlacesTests
//
//  Created by Said Rehouni on 28/11/24.
//

import XCTest
@testable import Places

final class RemoteLocationsRepositoryTests: XCTestCase {
    func test_fetchRecommendedLocations_endpoint() async throws {
        let httpClientMockResult: Result<Data, HTTPClientError> = .success(Data())
        let httpClientMock = HTTPClientMock(result: httpClientMockResult)
        let sut = RemoteLocationsRepository(httpClient: httpClientMock,
                                            errorMapper: LocationsDomainErrorMapper())
        
        // WHEN
        _ = try? await sut.fetchRecommendedLocations()
        
        // THEN
        XCTAssertEqual(httpClientMock.capturedEndpoint?.0.path, "abnamrocoesd/assignment-ios/main/locations.json")
        XCTAssertEqual(httpClientMock.capturedEndpoint?.0.queryParameters.count, 0)
        XCTAssertEqual(httpClientMock.capturedEndpoint?.0.method, .get)
        XCTAssertEqual(httpClientMock.capturedEndpoint?.1, "https://raw.githubusercontent.com/")
    }
    
    func test_fetchRecommendedLocations_succeeds() async throws {
        let data =
            """
            {
            "locations": 
                [
                  {
                    "name": "Amsterdam",
                    "lat": 52.3547498,
                    "long": 4.8339215
                  },
                  {
                    "name": "Mumbai",
                    "lat": 19.0823998,
                    "long": 72.8111468
                  },
                  {
                    "name": "Copenhagen",
                    "lat": 55.6713442,
                    "long": 12.523785
                  },
                  {
                    "lat": 40.4380638,
                    "long": -3.7495758
                  }
                ]
            }
            """.data(using: .utf8)
        
        let httpClientMockResult: Result<Data, HTTPClientError> = .success(data!)
        let httpClientMock = HTTPClientMock(result: httpClientMockResult)
        let sut = RemoteLocationsRepository(httpClient: httpClientMock,
                                            errorMapper: LocationsDomainErrorMapper())
        
        // WHEN
        let result = try await sut.fetchRecommendedLocations()
        
        // THEN
        XCTAssertEqual(result.count, 4)
        
        XCTAssertEqual(result[0].name, "Amsterdam")
        XCTAssertEqual(result[0].latitude, 52.3547498)
        XCTAssertEqual(result[0].longitude, 4.8339215)
        
        XCTAssertEqual(result[1].name, "Mumbai")
        XCTAssertEqual(result[1].latitude, 19.0823998)
        XCTAssertEqual(result[1].longitude, 72.8111468)
        
        XCTAssertEqual(result[2].name, "Copenhagen")
        XCTAssertEqual(result[2].latitude, 55.6713442)
        XCTAssertEqual(result[2].longitude, 12.523785)
        
        XCTAssertNil(result[3].name)
        XCTAssertEqual(result[3].latitude, 40.4380638)
        XCTAssertEqual(result[3].longitude, -3.7495758)
    }
    
    func test_fetchRecommendedLocations_fails_when_badFormattedJSON() async throws {
        let data =
            """
            {
            "locations": 
                [
                  {
                    "name": "Amsterdam",
                    "lat": 52.3547498,
                    "long": 4.8339215
                  },
                  {
                    "name": "Mumbai",
                    "lat": 19.0823998,
                    "long": 72.8111468
                  },
                  {
                    "name": "Copenhagen",
                    "lat": 55.6713442,
                    "long": 12.523785
                  },
                  {
                    "lat": 40.4380638,
               
                  }
                ]
            }
            """.data(using: .utf8)
        
        let httpClientMockResult: Result<Data, HTTPClientError> = .success(data!)
        let httpClientMock = HTTPClientMock(result: httpClientMockResult)
        let sut = RemoteLocationsRepository(httpClient: httpClientMock,
                                            errorMapper: LocationsDomainErrorMapper())
        
        // WHEN
        do {
            let result = try await sut.fetchRecommendedLocations()
            XCTFail("Expected an error, but got \(result)")
        } catch {
            // THEN
            XCTAssertEqual(error, .generic)
        }
    }
    
    func test_fetchRecommendedLocations_fails_when_httpFails() async throws {
        let httpClientMockResult: Result<Data, HTTPClientError> = .failure(.serverError)
        let httpClientMock = HTTPClientMock(result: httpClientMockResult)
        let sut = RemoteLocationsRepository(httpClient: httpClientMock,
                                            errorMapper: LocationsDomainErrorMapper())
        
        // WHEN
        do {
            let result = try await sut.fetchRecommendedLocations()
            XCTFail("Expected an error, but got \(result)")
        } catch {
            // THEN
            XCTAssertEqual(error, .generic)
        }
    }
}
