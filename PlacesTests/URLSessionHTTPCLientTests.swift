//
//  URLSessionHTTPCLientTests.swift
//  PlacesTests
//
//  Created by Said Rehouni on 27/11/24.
//

import XCTest
@testable import Places

final class URLSessionHTTPCLientTests: XCTestCase {

    func test_makeRequest_succeeds_when_statusCodeIs200() async throws {
        // GIVEN
        let response = HTTPURLResponseMock(statusCode: 200)
        let expectedData = Data()
        
        let urlSessionMockresult: Result<(Data, URLResponseType), any Error> = .success((expectedData, response))
        let session = URLSessionMock(result: urlSessionMockresult)
        
        let sut = URLSessionHTTPCLient(session: session,
                                       requestMaker: URLSessionRequestMaker(),
                                       errorResolver: URLSessionErrorResolver())
        
        let endpoint = Endpoint(path: "anyPath",
                                queryParameters: [:],
                                method: .get)
        
        // WHEN
        let result = await sut.makeRequest(endpoint: endpoint, baseUrl: "https://google.com")
    
        // THEN
        let data = try XCTUnwrap(result.get())
        XCTAssertEqual(data, expectedData)
    }
    
    func test_makeRequest_failsWithClientError_when_statusCodeIsNot200() async {
        // GIVEN
        let response = HTTPURLResponseMock(statusCode: 400)
        let expectedData = Data()
        
        let urlSessionMockresult: Result<(Data, URLResponseType), any Error> = .success((expectedData, response))
        let session = URLSessionMock(result: urlSessionMockresult)
        
        let sut = URLSessionHTTPCLient(session: session,
                                       requestMaker: URLSessionRequestMaker(),
                                       errorResolver: URLSessionErrorResolver())
        
        let endpoint = Endpoint(path: "anyPath",
                                queryParameters: [:],
                                method: .get)
        
        // WHEN
        let result = await sut.makeRequest(endpoint: endpoint, baseUrl: "https://google")
    
        // THEN
        guard case .failure(let error) = result else {
            XCTFail("Expected .failure, got .success")
            return
        }

        XCTAssertEqual(error, .clientError)
    }
    
    func test_makeRequest_failsWithServerError_when_statusCodeIsNot200() async {
        // GIVEN
        let response = HTTPURLResponseMock(statusCode: 500)
        let expectedData = Data()
        
        let urlSessionMockresult: Result<(Data, URLResponseType), any Error> = .success((expectedData, response))
        let session = URLSessionMock(result: urlSessionMockresult)
        
        let sut = URLSessionHTTPCLient(session: session,
                                       requestMaker: URLSessionRequestMaker(),
                                       errorResolver: URLSessionErrorResolver())
        
        let endpoint = Endpoint(path: "anyPath",
                                queryParameters: [:],
                                method: .get)
        
        // WHEN
        let result = await sut.makeRequest(endpoint: endpoint, baseUrl: "https://google")
    
        // THEN
        guard case .failure(let error) = result else {
            XCTFail("Expected .failure, got .success")
            return
        }

        XCTAssertEqual(error, .serverError)
    }
    
    func test_makeRequest_failsWithGenericError_when_requestsFails() async {
        // GIVEN
        let urlSessionMockresult: Result<(Data, URLResponseType), any Error> = .failure(NSError(domain: "anError", code: 0))
        let session = URLSessionMock(result: urlSessionMockresult)
        
        let sut = URLSessionHTTPCLient(session: session,
                                       requestMaker: URLSessionRequestMaker(),
                                       errorResolver: URLSessionErrorResolver())
        
        let endpoint = Endpoint(path: "anyPath",
                                queryParameters: [:],
                                method: .get)
        
        // WHEN
        let result = await sut.makeRequest(endpoint: endpoint, baseUrl: "")
    
        // THEN
        guard case .failure(let error) = result else {
            XCTFail("Expected .failure, got .success")
            return
        }

        XCTAssertEqual(error, .generic)
    }
}
