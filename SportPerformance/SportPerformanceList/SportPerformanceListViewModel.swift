//
//  SportPerformanceListViewModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import Foundation

class SportPerformanceListViewModel: ObservableObject {

    private weak var coordinator: PerformanceListCoordinatorDelegate?
    private let firebaseStoreService: FirebaseStoreServiceProtocol
    private let dataPersistenceManager: DataPersistenceManagerProtocol

    @Published var alertConfig: AlertConfig?
    @Published private(set) var performanceCollection: [PerformanceModel] = []
    @Published private(set) var progressHudState: ProgressHudState = .hideProgress

    // MARK: Init
    init(
        coordinator: PerformanceListCoordinatorDelegate?,
        firebaseStoreService: FirebaseStoreServiceProtocol,
        dataPersistenceManager: DataPersistenceManagerProtocol
    ) {
        self.coordinator = coordinator
        self.firebaseStoreService = firebaseStoreService
        self.dataPersistenceManager = dataPersistenceManager
        self.getPerformanceCollection()
    }

    // MARK: Methods
    func goToNewSportPerformance() {
        coordinator?.goToNewSportPerformance(delegate: self)
    }
}

// MARK: - Private methods
private extension SportPerformanceListViewModel {

    func getPerformanceCollection() {
        Task {
            do {
                let localData = try dataPersistenceManager.getPerformanceCollection()
                let remoteData = try await firebaseStoreService.getPerformanceCollection()
                let combinedAndSortedData = (localData + remoteData).sorted { $0.date > $1.date }
                await MainActor.run {
                    performanceCollection = combinedAndSortedData
                    progressHudState = .hideProgress
                }
            } catch {
                await MainActor.run {
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
                    progressHudState = .hideProgress
                }
            }
        }
    }
}

// MARK: - NewSportPerformanceDelegate
extension SportPerformanceListViewModel: NewSportPerformanceDelegate {

    func updatePerformanceList() {
        getPerformanceCollection()
    }
}
