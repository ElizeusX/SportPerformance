//
//  PerformanceListViewModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import Foundation

class PerformanceListViewModel: ObservableObject {

    private weak var coordinator: PerformanceListCoordinatorDelegate?

    @Published var performanceData: [PerformanceModel] = MockData.performanceData

    // MARK: Init
    init(
        coordinator: PerformanceListCoordinatorDelegate?
    ) {
        self.coordinator = coordinator
    }

    // MARK: Methods
    func goToNewSportPerformance() {
        coordinator?.goToNewSportPerformance()
    }
}
