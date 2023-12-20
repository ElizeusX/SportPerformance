//
//  SportPerformanceTests.swift
//  SportPerformanceTests
//
//  Created by Elizeus Chrabrov on 07.12.2023.
//

import XCTest
import Combine
@testable import SportPerformance

final class SportPerformanceListViewModelTests: XCTestCase {

    var subscriptions: Set<AnyCancellable> = []

    override func tearDown() {
        super.tearDown()
        subscriptions.removeAll()
    }

    func testLoadFilteredDataWithSuccess() {
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

    func testLoadFilteredDataFromFirebaseWithError() {
        let expectation = XCTestExpectation(description: "Filtered data should not be loaded")
        let viewModel = SportPerformanceListViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManagerWithError(),
            dataPersistenceManager: MockDataPersistenceManager()
        )
        viewModel.selectedRepository = .remote
        viewModel.$alertConfig
            .dropFirst()
            .sink { alert in
                XCTAssertEqual(alert?.message, GenericError.unexpectedError.localizedDescription)
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.filteredPerformanceCollection, [])
    }

    func testLoadFilteredDataFromDataPersistenceWithError() {
        let viewModel = SportPerformanceListViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManagerWithError()
        )
        viewModel.selectedRepository = .local

        XCTAssertEqual(viewModel.alertConfig?.message, DataPersistenceError.errorLoadingData.message)
        XCTAssertEqual(viewModel.filteredPerformanceCollection, [])
    }

    func testLoadFilteredLocalDataWithSuccess() {
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

    func testLoadFilteredRemoteDataWithSuccess() {
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

    func testDeleteLocalItemWithSuccess() {
        let expectation = XCTestExpectation(description: "Filtered data should be loaded successfully")
        let viewModel = SportPerformanceListViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager()
        )
        let localMockItem = try! XCTUnwrap(MockData.performanceData.first { $0.repository == .local })
        viewModel.selectedRepository = .all
        viewModel.$filteredPerformanceCollection
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(viewModel.filteredPerformanceCollection.contains(localMockItem))
        viewModel.deletePerformance(with: localMockItem.id, for: .local)
        XCTAssertFalse(viewModel.filteredPerformanceCollection.contains(localMockItem))
        XCTAssertNil(viewModel.alertConfig)
    }

    func testDeleteRemoteItemWithSuccess() {
        let expectation = XCTestExpectation(description: "Filtered data should be loaded successfully")
        let expectation2 = XCTestExpectation(description: "Item was deleted")
        let viewModel = SportPerformanceListViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager()
        )
        let remoteMockItem = try! XCTUnwrap(MockData.performanceData.first { $0.repository == .remote })
        viewModel.selectedRepository = .all
        viewModel.$filteredPerformanceCollection
            .dropFirst()
            .sink { data in
                if data.count == 2 {
                    // Data loaded
                    expectation.fulfill()
                } else if data.count == 1 {
                    // After deleting performance
                    expectation2.fulfill()
                }
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(viewModel.filteredPerformanceCollection.contains(remoteMockItem))
        viewModel.deletePerformance(with: remoteMockItem.id, for: .remote)
        wait(for: [expectation2], timeout: 1)
        XCTAssertFalse(viewModel.filteredPerformanceCollection.contains(remoteMockItem))
        XCTAssertNil(viewModel.alertConfig)
    }

    func testDeleteLocalItemWithError() {
        let expectation = XCTestExpectation(description: "Filtered data should be loaded successfully")
        let expectation2 = XCTestExpectation(description: "Item wasn't deleted")
        let viewModel = SportPerformanceListViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManagerWithDeleteError()
        )
        let localMockItem = try! XCTUnwrap(MockData.performanceData.first { $0.repository == .local })
        viewModel.selectedRepository = .all
        viewModel.$filteredPerformanceCollection
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        viewModel.$alertConfig
            .dropFirst()
            .sink { alert in
                XCTAssertEqual(alert?.message, DataPersistenceError.errorDeletingData.message)
                expectation2.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(viewModel.filteredPerformanceCollection.contains(localMockItem))
        viewModel.deletePerformance(with: localMockItem.id, for: .local)
        wait(for: [expectation2], timeout: 1)
        XCTAssertTrue(viewModel.filteredPerformanceCollection.contains(localMockItem))
    }

    func testDeleteRemoteItemWithError() {
        let expectation = XCTestExpectation(description: "Filtered data should be loaded successfully")
        let expectation2 = XCTestExpectation(description: "Item wasn't deleted")
        let viewModel = SportPerformanceListViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManagerWithDeleteError(),
            dataPersistenceManager: MockDataPersistenceManager()
        )
        let remoteMockItem = try! XCTUnwrap(MockData.performanceData.first { $0.repository == .remote })
        viewModel.selectedRepository = .all
        viewModel.$filteredPerformanceCollection
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        viewModel.$alertConfig
            .dropFirst()
            .sink { alert in
                XCTAssertEqual(alert?.message, GenericError.unexpectedError.localizedDescription)
                expectation2.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(viewModel.filteredPerformanceCollection.contains(remoteMockItem))
        viewModel.deletePerformance(with: remoteMockItem.id, for: .remote)
        wait(for: [expectation2], timeout: 1)
        XCTAssertTrue(viewModel.filteredPerformanceCollection.contains(remoteMockItem))
    }
}
