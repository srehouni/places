//
//  LocationsListViewModelTests.swift
//  PlacesTests
//
//  Created by Said Rehouni on 1/12/24.
//

import XCTest
import Combine
@testable import Places

final class LocationsListViewModelTests: XCTestCase {
    @MainActor
    func test_onAppear_presents_successState_when_locations_are_fetched() {
        // GIVEN
        let expectedLocations = Location.makeLocationsStub()
        let getRecommentedLocationsUseCaseMock = GetRecommendedLocationsUseCaseMock(result: .success(expectedLocations))
        let sut = LocationsListViewModel(getRecommentedLocations: getRecommentedLocationsUseCaseMock)
        
        var capturedState: [LocationsListViewModel.State] = []
        var cancellables: [AnyCancellable] = []
        let expectation = expectation(description: "Waiting for state to update")
        
        XCTAssertEqual(sut.state, .loading)
        
        sut.$state.dropFirst().sink { state in
            capturedState.append(state)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // WHEN
        sut.onAppear()
        
        // THEN
        wait(for: [expectation], timeout: 1.0)
        guard case .success(let locations) = sut.state else {
            XCTFail("Expected success, got \(sut.state)")
            return
        }
        XCTAssertEqual(locations, expectedLocations)
        XCTAssertFalse(sut.shouldPresentModalErrorAlert)
    }
    
    @MainActor
    func test_onAppear_presents_failureState_when_locations_areNot_fetched() {
        // GIVEN
        let getRecommentedLocationsUseCaseMock = GetRecommendedLocationsUseCaseMock(result: .failure(NSError(domain: "anError", code: 0)))
        let sut = LocationsListViewModel(getRecommentedLocations: getRecommentedLocationsUseCaseMock)
        
        var capturedState: [LocationsListViewModel.State] = []
        var cancellables: [AnyCancellable] = []
        let expectation = expectation(description: "Waiting for state to update")
        
        XCTAssertEqual(sut.state, .loading)
        
        sut.$state.dropFirst().sink { state in
            capturedState.append(state)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // WHEN
        sut.onAppear()
        
        // THEN
        wait(for: [expectation], timeout: 1.0)
        guard case .failure(let message) = sut.state else {
            XCTFail("Expected failure, got \(sut.state)")
            return
        }
        XCTAssertEqual(message, "Something went wrong")
        XCTAssertFalse(sut.shouldPresentModalErrorAlert)
    }
    
    func test_addLocation_succeeds_when_provided_location_is_valid_and_locations_isEmpty() {
        // GIVEN
        let expectedLocation = try! Location.create(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215)
        let getRecommentedLocationsUseCaseMock = GetRecommendedLocationsUseCaseMock(result: .success([]))
        let sut = LocationsListViewModel(getRecommentedLocations: getRecommentedLocationsUseCaseMock)
        
        var capturedState: [LocationsListViewModel.State] = []
        var cancellables: [AnyCancellable] = []
        
        XCTAssertEqual(sut.state, .loading)
        
        sut.$state.dropFirst().sink { state in
            capturedState.append(state)
        }.store(in: &cancellables)
        
        // WHEN
        sut.addLocation(name: "Amsterdam", latitude: "52.3547498", longitude: "4.8339215")
        
        // THEN
        XCTAssertFalse(sut.shouldPresentModalErrorAlert)
        guard case .success(let locations) = sut.state else {
            XCTFail("Expected success, got \(sut.state)")
            return
        }
        XCTAssertEqual(locations.count, 1)
        XCTAssertEqual(locations[0], expectedLocation)
    }
    
    @MainActor
    func test_addLocation_succeeds_when_provided_location_is_valid_and_locations_isNotEmpty() {
        // GIVEN
        let expectedLocations = Location.makeLocationsStub()
        let addedExpectedLocation = try! Location.create(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215)
        let getRecommentedLocationsUseCaseMock = GetRecommendedLocationsUseCaseMock(result: .success(expectedLocations))
        let sut = LocationsListViewModel(getRecommentedLocations: getRecommentedLocationsUseCaseMock)
        
        var capturedState: [LocationsListViewModel.State] = []
        var cancellables: [AnyCancellable] = []
        var expectation: XCTestExpectation? = expectation(description: "Waiting for state to update")
        
        XCTAssertEqual(sut.state, .loading)
        
        sut.$state.dropFirst().sink { state in
            capturedState.append(state)
            expectation?.fulfill()
        }.store(in: &cancellables)
        
        // WHEN
        sut.onAppear()
        
        // AND
        wait(for: [expectation!], timeout: 1.0)
        expectation = nil
        sut.addLocation(name: "Amsterdam", latitude: "52.3547498", longitude: "4.8339215")
        
        // THEN
        XCTAssertFalse(sut.shouldPresentModalErrorAlert)
        guard case .success(let locations) = sut.state else {
            XCTFail("Expected success, got \(sut.state)")
            return
        }
        XCTAssertEqual(locations.count, 3)
        XCTAssertEqual(locations[0], expectedLocations[0])
        XCTAssertEqual(locations[1], expectedLocations[1])
        XCTAssertEqual(locations[2], addedExpectedLocation)
    }
    
    @MainActor
    func test_addLocation_fails_when_provided_location_isNot_valid_and_locations_isNotEmpty() {
        // GIVEN
        let expectedLocations = Location.makeLocationsStub()
        let getRecommentedLocationsUseCaseMock = GetRecommendedLocationsUseCaseMock(result: .success(expectedLocations))
        let sut = LocationsListViewModel(getRecommentedLocations: getRecommentedLocationsUseCaseMock)
        
        var capturedState: [LocationsListViewModel.State] = []
        var cancellables: [AnyCancellable] = []
        var expectation: XCTestExpectation? = expectation(description: "Waiting for state to update")
        
        XCTAssertEqual(sut.state, .loading)
        
        sut.$state.dropFirst().sink { state in
            capturedState.append(state)
            expectation?.fulfill()
        }.store(in: &cancellables)
        
        // WHEN
        sut.onAppear()
        
        // AND
        wait(for: [expectation!], timeout: 1.0)
        expectation = nil
        sut.addLocation(name: "Amsterdam", latitude: "1252.3547498", longitude: "324.8339215")
        
        // THEN
        XCTAssertTrue(sut.shouldPresentModalErrorAlert)
        guard case .success(let locations) = sut.state else {
            XCTFail("Expected success, got \(sut.state)")
            return
        }
        XCTAssertEqual(locations, expectedLocations)
    }
}
