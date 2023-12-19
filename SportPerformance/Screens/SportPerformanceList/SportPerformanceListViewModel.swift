//
//  SportPerformanceListViewModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import Foundation
import Combine

final class SportPerformanceListViewModel: ObservableObject {

    private weak var coordinator: PerformanceListCoordinatorDelegate?
    private let firebaseStoreManager: FirebaseStoreManagerProtocol
    private let dataPersistenceManager: DataPersistenceManagerProtocol

    private var subscriptions: Set<AnyCancellable> = []
    private var performanceCollection: [PerformanceModel] = []

    @Published var alertConfig: AlertConfig?
    @Published var selectedRepository: Repository = .all
    @Published private(set) var filteredPerformanceCollection: [PerformanceModel] = []
    @Published private(set) var progressHudState: ProgressHudState = .hideProgress

    var showEmptyState: Bool {
        filteredPerformanceCollection.isEmpty
    }

    // MARK: Init
    init(
        coordinator: PerformanceListCoordinatorDelegate?,
        firebaseStoreManager: FirebaseStoreManagerProtocol,
        dataPersistenceManager: DataPersistenceManagerProtocol
    ) {
        self.coordinator = coordinator
        self.firebaseStoreManager = firebaseStoreManager
        self.dataPersistenceManager = dataPersistenceManager
        self.getLocalPerformanceCollection()
        self.getRemotePerformanceCollection()
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

    func getLocalPerformanceCollection() {
        do {
            let data = try dataPersistenceManager.getPerformanceCollection()
            performanceCollection.removeAll(where: { $0.repository == .local })
            performanceCollection += data
            setupFilter()
        } catch {
            showAlert(for: error)
        }
    }

    func getRemotePerformanceCollection() {
        progressHudState = .showProgress
        Task {
            do {
                let data = try await firebaseStoreManager.getPerformanceCollection()
                performanceCollection.removeAll(where: { $0.repository == .remote })
                performanceCollection += data
                setupFilter()
                await MainActor.run {
                    progressHudState = .hideProgress
                }
            } catch {
                await MainActor.run {
                    showAlert(for: error)
                    progressHudState = .hideProgress
                }
            }
        }
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
        subscriptions.removeAll() // In cases where the filter needs to be updated.
        $selectedRepository
            .receive(on: DispatchQueue.main)
            .sink { [weak self] type in
                guard let self else { return }
                if type == .all {
                    filteredPerformanceCollection = performanceCollection
                        .sorted { $0.date > $1.date }
                } else {
                    filteredPerformanceCollection = performanceCollection
                        .filter({ $0.repository == type })
                        .sorted { $0.date > $1.date }
                }
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Private deletion methods
private extension SportPerformanceListViewModel {

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
}

// MARK: - NewSportPerformanceDelegate
extension SportPerformanceListViewModel: NewSportPerformanceDelegate {

    func updateLocallyPerformanceList() {
        getLocalPerformanceCollection()
    }

    func updateRemotelyPerformanceList() {
        getRemotePerformanceCollection()
    }
}
