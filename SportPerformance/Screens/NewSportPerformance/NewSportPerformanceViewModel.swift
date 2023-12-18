//
//  NewSportPerformanceViewModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 10.12.2023.
//

import Foundation

enum PerformanceTextFieldType: CaseIterable {
    case name
    case place

    var title: String {
        switch self {
        case .name:
            L.NewSportPerformance.textFieldNameTitle.string()
        case .place:
            L.NewSportPerformance.textFieldPlaceTitle.string()
        }
    }
    var placeholder: String {
        switch self {
        case .name:
            L.NewSportPerformance.textFieldNamePlaceholder.string()
        case .place:
            L.NewSportPerformance.textFieldPlacePlaceholder.string()
        }
    }
}

protocol NewSportPerformanceDelegate: AnyObject {
    func updatePerformanceList()
}

class NewSportPerformanceViewModel: ObservableObject {

    private weak var coordinator: NewSportPerformanceListCoordinatorDelegate?
    private let firebaseStoreManager: FirebaseStoreManagerProtocol
    private let dataPersistenceManager: DataPersistenceManagerProtocol
    private let delegate: NewSportPerformanceDelegate?

    @Published var selectedHours = 0
    @Published var selectedMinutes = 0
    @Published var selectedSeconds = 0
    @Published var warningMessageForDuration = ""
    @Published var alertConfig: AlertConfig?
    @Published var showSaveSelection = false
    @Published private(set) var progressHudState: ProgressHudState = .hideProgress
    @Published private var name = ""
    @Published private var warningMessageForName = ""
    @Published private var place = ""
    @Published private var warningMessageForPlace = ""

    // MARK: Init
    init(
        coordinator: NewSportPerformanceListCoordinatorDelegate?,
        firebaseStoreManager: FirebaseStoreManagerProtocol,
        dataPersistenceManager: DataPersistenceManagerProtocol,
        delegate: NewSportPerformanceDelegate?
    ) {
        self.coordinator = coordinator
        self.firebaseStoreManager = firebaseStoreManager
        self.dataPersistenceManager = dataPersistenceManager
        self.delegate = delegate
    }

    // MARK: Methods
    func savePerformanceRemotely() {
        let performanceModel = FirebasePerformanceModel(
            name: name,
            place: place,
            duration: getFormattedDuration(),
            date: Date.now
        )
        progressHudState = .showProgress
        firebaseStoreManager.addPerformance(performance: performanceModel) { [weak self] result in
            switch result {
            case .success:
                self?.progressHudState = .showSuccess
                self?.updateListAndFinish()
            case .failure(let error):
                self?.showAlert(for: error)
                self?.progressHudState = .hideProgress
            }
        }
    }

    func savePerformanceLocal() {
        let performance = PerformanceEntityStub(
            name: name,
            place: place,
            duration: getFormattedDuration()
        )
        do {
            try dataPersistenceManager.savePerformance(performance: performance)
            updateListAndFinish()
        } catch {
            showAlert(for: error)
        }
    }

    func primaryButtonAction() {
        guard !name.isEmpty else {
            warningMessageForName = L.NewSportPerformance.textFieldNameWarningMessage.string()
            return
        }
        guard !place.isEmpty else {
            warningMessageForPlace = L.NewSportPerformance.textFieldPlaceWarningMessage.string()
            return
        }
        guard (selectedHours + selectedMinutes + selectedSeconds) != 0 else {
            warningMessageForDuration = L.NewSportPerformance.durationWarningMessage.string()
            return
        }

        showSaveSelection = true
    }
}

// MARK: - Text field methods
extension NewSportPerformanceViewModel {

    func getTextFieldWarningMessage(for type: PerformanceTextFieldType) -> String {
        switch type {
        case .name:
            warningMessageForName
        case .place:
            warningMessageForPlace
        }
    }

    func getTextFieldText(for type: PerformanceTextFieldType) -> String {
        switch type {
        case .name:
            name
        case .place:
            place
        }
    }

    func setTextFieldText(for type: PerformanceTextFieldType, text: String) {
        switch type {
        case .name:
            name = text
        case .place:
            place = text
        }
    }
}

// MARK: - Private methods
private extension NewSportPerformanceViewModel {

    func getFormattedDuration() -> String {
        var dateComponents = DateComponents()
        dateComponents.hour = selectedHours
        dateComponents.minute = selectedMinutes
        dateComponents.second = selectedSeconds
        guard let date = Calendar.current.date(from: dateComponents) else {
            preconditionFailure("Data must exist")
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }

    func updateListAndFinish() {
        delegate?.updatePerformanceList()
        coordinator?.finishNewSportPerformance()
    }

    func showAlert(for error: Error) {
        if let error = error as? DataPersistenceError {
            alertConfig = AlertConfig(
                title: error.title,
                message: error.message
            )
        } else {
            alertConfig = AlertConfig(
                title: L.Errors.genericErrorTitle.string(),
                message: error.localizedDescription
            )
        }
    }
}
