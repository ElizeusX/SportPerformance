//
//  SportPerformanceTests.swift
//  SportPerformanceTests
//
//  Created by Elizeus Chrabrov on 07.12.2023.
//

import XCTest
import Combine
@testable import SportPerformance

final class SportPerformanceTests: XCTestCase {

    var subscriptions: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    override func tearDown() {
        super.tearDown()
        subscriptions.removeAll()
    }

    func testCreateSportPerformanceListWithSuccess() {
        let expectation = XCTestExpectation(description: "Filtered data should be loaded successfully")
        let viewModel = SportPerformanceListViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager()
        )
        let sortedMockData = MockData.performanceData.sorted(by: { $0.date > $1.date })
        viewModel.selectedRepository = .all
        viewModel.$filteredPerformanceCollection
            .dropFirst()
            .sink { data in
                XCTAssertEqual(data, sortedMockData)
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1)
        XCTAssertNil(viewModel.alertConfig)
    }

    func testFilterWithLocal() {
        let expectation = XCTestExpectation(description: "Filtered data should be loaded successfully")
        let viewModel = SportPerformanceListViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager()
        )
        let localSortedMockData = MockData.performanceData
            .sorted(by: { $0.date > $1.date })
            .filter { $0.repository == .local}
        viewModel.selectedRepository = .local
        viewModel.$filteredPerformanceCollection
            .dropFirst()
            .sink { data in
                XCTAssertEqual(data, localSortedMockData)
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1)
        XCTAssertNil(viewModel.alertConfig)
    }

    func testFilterWithRemote() {
        let expectation = XCTestExpectation(description: "Filtered data should be loaded successfully")
        let viewModel = SportPerformanceListViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager()
        )
        let localSortedMockData = MockData.performanceData
            .sorted(by: { $0.date > $1.date })
            .filter { $0.repository == .remote}
        viewModel.selectedRepository = .remote
        viewModel.$filteredPerformanceCollection
            .dropFirst()
            .sink { data in
                XCTAssertEqual(data, localSortedMockData)
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1)
        XCTAssertNil(viewModel.alertConfig)
    }
}
