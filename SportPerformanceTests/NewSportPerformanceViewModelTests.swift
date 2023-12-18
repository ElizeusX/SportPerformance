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

    func testSaveRemotelyWithError() {
        let expectation = XCTestExpectation(description: "Progress must be success")
        let viewModel = NewSportPerformanceViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManagerWithError(),
            dataPersistenceManager: MockDataPersistenceManager(),
            delegate: nil
        )
        viewModel.$alertConfig
            .dropFirst()
            .sink { alert in
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        viewModel.setTextFieldText(for: .name, text: "Name")
        viewModel.setTextFieldText(for: .place, text: "Place")
        viewModel.selectedHours = 1
        viewModel.savePerformanceRemotely()

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.alertConfig?.message, GenericError.unexpectedError.localizedDescription)
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

    func testSaveLocalWithError() {
        let viewModel = NewSportPerformanceViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManagerWithError(),
            delegate: nil
        )
        viewModel.setTextFieldText(for: .name, text: "Name")
        viewModel.setTextFieldText(for: .place, text: "Place")
        viewModel.selectedHours = 1
        viewModel.savePerformanceLocal()

        XCTAssertEqual(viewModel.alertConfig?.message, DataPersistenceError.errorSavingData.message)
    }

    func testWarningMessageForName() {
        let viewModel = NewSportPerformanceViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager(),
            delegate: nil
        )
        viewModel.setTextFieldText(for: .name, text: "")
        viewModel.setTextFieldText(for: .place, text: "Place")
        viewModel.selectedHours = 1
        viewModel.primaryButtonAction()

        XCTAssertEqual(viewModel.getTextFieldWarningMessage(for: .name), L.NewSportPerformance.textFieldNameWarningMessage.string())
    }

    func testWarningMessageForPlace() {
        let viewModel = NewSportPerformanceViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager(),
            delegate: nil
        )
        viewModel.setTextFieldText(for: .name, text: "Name")
        viewModel.setTextFieldText(for: .place, text: "")
        viewModel.selectedHours = 1
        viewModel.primaryButtonAction()

        XCTAssertEqual(viewModel.getTextFieldWarningMessage(for: .place), L.NewSportPerformance.textFieldPlaceWarningMessage.string())
    }

    func testWarningMessageForDuration() {
        let viewModel = NewSportPerformanceViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager(),
            delegate: nil
        )
        viewModel.setTextFieldText(for: .name, text: "Name")
        viewModel.setTextFieldText(for: .place, text: "Place")
        viewModel.primaryButtonAction()

        XCTAssertEqual(viewModel.warningMessageForDuration, L.NewSportPerformance.durationWarningMessage.string())
    }
}
