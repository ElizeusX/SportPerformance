//
//  NewSportPerformanceViewModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 10.12.2023.
//

import Foundation

class NewSportPerformanceViewModel: ObservableObject {

    private weak var coordinator: NewSportPerformanceListCoordinatorDelegate?
    private let firebaseStoreService: FirebaseStoreServiceProtocol

    @Published var name = ""
    @Published var place = ""
    @Published var selectedHours = 0
    @Published var selectedMinutes = 0
    @Published var selectedSeconds = 0
    @Published private(set) var progressHudState: ProgressHudState = .hideProgress

    // MARK: Init
    init(
        coordinator: NewSportPerformanceListCoordinatorDelegate?,
        firebaseStoreService: FirebaseStoreServiceProtocol
    ) {
        self.coordinator = coordinator
        self.firebaseStoreService = firebaseStoreService
    }


    // MARK: Methods
    func createSportPerformance() {
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
                self?.coordinator?.finishNewSportPerformance()
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.progressHudState = .hideProgress
        }

        // TODO: Name, place, duration and save to remote or local
    }

    // MARK: Private methods
    private func getFormattedDuration() -> String {
        var dateComponents = DateComponents()
        dateComponents.hour = selectedHours
        dateComponents.minute = selectedMinutes
        dateComponents.second = selectedSeconds
        guard let date = Calendar.current.date(from: dateComponents) else { return "" /*error handler*/ }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
}
