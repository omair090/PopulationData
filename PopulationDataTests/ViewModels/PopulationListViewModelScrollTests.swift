//
//  PopulationListViewModelScrollTests.swift
//  PopulationData
//
//  Created by Muhammad Umair on 28/04/1446 AH.
//


import XCTest
import Combine
@testable import PopulationData

final class PopulationListViewModelScrollTests: XCTestCase {
    var viewModel: PopulationListViewModel!
    var mockService: MockPopulationService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockPopulationService()
        viewModel = PopulationListViewModel(service: mockService)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }

    func testScrollTriggersLoadMore() {
        let expectation = XCTestExpectation(description: "Trigger load more on scroll")

        viewModel.stateData
            .dropFirst()
            .sink { states in
                XCTAssertGreaterThan(states.count, 0, "Expected data to load on scroll")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchMoreStateData()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got failure with error: \(error)")
                }
            }, receiveValue: { })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
}
