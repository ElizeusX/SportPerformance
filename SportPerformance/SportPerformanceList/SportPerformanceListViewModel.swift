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

    @Published var error: Error?
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
                self.error = error /*error handling*/
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
