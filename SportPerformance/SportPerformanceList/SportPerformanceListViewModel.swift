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

    @Published var alertConfig: AlertConfig?
    @Published private(set) var performanceCollection: [PerformanceModel] = []
    @Published private(set) var progressHudState: ProgressHudState = .hideProgress

    // MARK: Init
    init(
        coordinator: PerformanceListCoordinatorDelegate?,
        firebaseStoreService: FirebaseStoreServiceProtocol
    ) {
        self.coordinator = coordinator
        self.firebaseStoreService = firebaseStoreService
        self.getPerformanceCollection()
    }

    // MARK: Methods
    func goToNewSportPerformance() {
        coordinator?.goToNewSportPerformance(delegate: self)
    }

    private func getPerformanceCollection() {
        progressHudState = .showProgress
        Task { @MainActor in
            do {
                performanceCollection = try await firebaseStoreService.getPerformanceCollection()
                progressHudState = .hideProgress
            } catch {
                alertConfig = AlertConfig(
                    title: L.Errors.genericErrorTitle.string(),
                    message: error.localizedDescription
                )
                progressHudState = .hideProgress
            }
        }
    }
}

// MARK: - NewSportPerformanceDelegate
extension SportPerformanceListViewModel: NewSportPerformanceDelegate {

    func updatePerformanceListForRemote() {
        getPerformanceCollection()
    }

    func updatePerformanceListForLocal() {
        // TODO: CoreData
    }
}
