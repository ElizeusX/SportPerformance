//
//  SportPerformanceListViewModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import Foundation
import Combine

class SportPerformanceListViewModel: ObservableObject {

    private weak var coordinator: PerformanceListCoordinatorDelegate?
    private let firebaseStoreManager: FirebaseStoreManagerProtocol
    private let dataPersistenceManager: DataPersistenceManagerProtocol

    private var subscriptions: Set<AnyCancellable> = []

    @Published var alertConfig: AlertConfig?
    @Published private(set) var performanceCollection: [PerformanceModel] = []
    @Published var filteredPerformanceCollection: [PerformanceModel] = []
    @Published var selectedRepository: Repository = .all
    @Published private(set) var progressHudState: ProgressHudState = .hideProgress

    // MARK: Init
    init(
        coordinator: PerformanceListCoordinatorDelegate?,
        firebaseStoreManager: FirebaseStoreManagerProtocol,
        dataPersistenceManager: DataPersistenceManagerProtocol
    ) {
        self.coordinator = coordinator
        self.firebaseStoreManager = firebaseStoreManager
        self.dataPersistenceManager = dataPersistenceManager
        self.getPerformanceCollection()
    }

    // MARK: Methods
    func goToNewSportPerformance() {
        coordinator?.goToNewSportPerformance(delegate: self)
    }

    func deletePerformance(with id: String, for type: Repository) {
        if type == .local {
            deleteLocalPerformance(with: id)
        } else {
            deleteRemotePerformance(with: id)
        }
    }
}

// MARK: - Private methods
private extension SportPerformanceListViewModel {

    func getPerformanceCollection() {
        progressHudState = .showProgress
        Task {
            do {
                let localData = try dataPersistenceManager.getPerformanceCollection()
                let remoteData = try await firebaseStoreManager.getPerformanceCollection()
                let combinedAndSortedData = (localData + remoteData).sorted { $0.date > $1.date }
                await MainActor.run {
                    performanceCollection = combinedAndSortedData
                    progressHudState = .hideProgress
                }
                subscriptions.removeAll()
                setupFilter()
            } catch {
                await MainActor.run {
                    showAlert(for: error)
                    progressHudState = .hideProgress
                }
            }
        }
    }

    func deleteLocalPerformance(with id: String) {
        do {
            try dataPersistenceManager.deletePerformance(with: id)
            deleteFromPerformanceCollection(with: id)
        } catch {
            showAlert(for: error)
        }
    }

    func deleteRemotePerformance(with id: String) {
        progressHudState = .showSuccess
        Task {
            do {
                try await firebaseStoreManager.deletePerformance(with: id)
                await MainActor.run {
                    deleteFromPerformanceCollection(with: id)
                }
            } catch {
                await MainActor.run {
                    showAlert(for: error)
                    progressHudState = .hideProgress
                }
            }
        }
    }

    func deleteFromPerformanceCollection(with id: String) {
        performanceCollection.removeAll { $0.id == id }
        filteredPerformanceCollection.removeAll { $0.id == id }
        progressHudState = .showSuccess
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

    func setupFilter() {
        $selectedRepository
            .receive(on: DispatchQueue.main)
            .sink { [weak self] type in
                guard let self else { return }
                if type == .all {
                    filteredPerformanceCollection = performanceCollection
                } else {
                    filteredPerformanceCollection = performanceCollection.filter { $0.repository == type }
                }
            }
            .store(in: &subscriptions)
    }
}

// MARK: - NewSportPerformanceDelegate
extension SportPerformanceListViewModel: NewSportPerformanceDelegate {

    func updatePerformanceList() {
        getPerformanceCollection()
    }
}
