//
//  NewSportPerformanceViewModelTests.swift
//  SportPerformanceTests
//
//  Created by Elizeus Chrabrov on 18.12.2023.
//

import XCTest
import Combine
@testable import SportPerformance

final class NewSportPerformanceViewModelTests: XCTestCase {

    var subscriptions: Set<AnyCancellable> = []

    override func tearDown() {
        super.tearDown()
        subscriptions.removeAll()
    }

    func testSaveRemotelyWithSuccess() {
        let expectation = XCTestExpectation(description: "Progress must be success")
        let viewModel = NewSportPerformanceViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager(),
            delegate: nil
        )
        viewModel.$progressHudState
            .dropFirst()
            .sink { state in
                if state == .showSuccess {
                    expectation.fulfill()
                }
            }
            .store(in: &subscriptions)
        viewModel.setTextFieldText(for: .name, text: "Name")
        viewModel.setTextFieldText(for: .place, text: "Place")
        viewModel.selectedHours = 1
        viewModel.savePerformanceRemotely()

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.progressHudState, ProgressHudState.showSuccess)
        XCTAssertNil(viewModel.alertConfig)
    }

    func testSaveLocalWithSuccess() {
        let viewModel = NewSportPerformanceViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager(),
            delegate: nil
        )
        viewModel.setTextFieldText(for: .name, text: "Name")
        viewModel.setTextFieldText(for: .place, text: "Place")
        viewModel.selectedHours = 1
        viewModel.savePerformanceLocal()

        XCTAssertNil(viewModel.alertConfig)
    }
}
