//
//  NewSportPerformanceViewModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 10.12.2023.
//

import Foundation

protocol NewSportPerformanceDelegate: AnyObject {
    func updatePerformanceList()
}

class NewSportPerformanceViewModel: ObservableObject {

    private weak var coordinator: NewSportPerformanceListCoordinatorDelegate?
    private let firebaseStoreService: FirebaseStoreServiceProtocol
    private let dataPersistenceManager: DataPersistenceManagerProtocol
    private let delegate: NewSportPerformanceDelegate?

    @Published var name = ""
    @Published var place = ""
    @Published var selectedHours = 0
    @Published var selectedMinutes = 0
    @Published var selectedSeconds = 0
    @Published var alertConfig: AlertConfig?
    @Published var showSaveSelection = false
    @Published private(set) var progressHudState: ProgressHudState = .hideProgress

    // MARK: Init
    init(
        coordinator: NewSportPerformanceListCoordinatorDelegate?,
        firebaseStoreService: FirebaseStoreServiceProtocol,
        dataPersistenceManager: DataPersistenceManagerProtocol,
        delegate: NewSportPerformanceDelegate?
    ) {
        self.coordinator = coordinator
        self.firebaseStoreService = firebaseStoreService
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
        firebaseStoreService.addPerformance(performance: performanceModel) { [weak self] result in
            switch result {
            case .success:
                self?.updateListAndFinish()
            case .failure(let error):
                self?.alertConfig = AlertConfig(
                    title: L.Errors.genericErrorTitle.string(),
                    message: error.localizedDescription
                )
                self?.progressHudState = .hideProgress
            }
        }
    }

    func savePerformanceLocal() {
        let performance = PerformanceModel(
            id: UUID().uuidString,
            name: name,
            place: place,
            duration: getFormattedDuration(),
            date: Date.now,
            repository: .local
        )
        do {
            try dataPersistenceManager.savePerformance(performance: performance)
            updateListAndFinish()
        } catch {
            alertConfig = AlertConfig(
                title: L.Errors.genericErrorTitle.string(),
                message: error.localizedDescription
            )
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
}
