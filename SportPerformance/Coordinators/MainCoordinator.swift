//
//  MainCoordinator.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 07.12.2023.
//

import SwiftUI

class MainCoordinator: UINavigationController {
    
    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setViewControllers(
            [
                UIHostingController(rootView: SportPerformanceListView(
                    viewModel: SportPerformanceListViewModel(coordinator: self)
                ))
            ],
            animated: false
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func cancel(animated: Bool = true) {
        popViewController(animated: animated)
    }
}

// MARK: - Delegates
extension MainCoordinator: PerformanceListCoordinatorDelegate {

    func goToNewSportPerformance() {
        let view = NewSportPerformanceView(
            viewModel: NewSportPerformanceViewModel()
        )
        pushViewController(
            UIHostingController(rootView: view),
            animated: true
        )
    }
}

extension MainCoordinator: NewSportPerformanceListCoordinatorDelegate {

    func finishNewSportPerformance() {
        cancel()
    }
}
