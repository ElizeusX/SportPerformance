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
        let view = SportPerformanceListView(
            viewModel: SportPerformanceListViewModel(coordinator: self),
            navigationPropagation: NavigationPropagation()
        )
        let hostingController = HostingController(navigationPropagation: view.navigationPropagation) { view }
        self.setViewControllers([hostingController], animated: false)
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
            viewModel: NewSportPerformanceViewModel(coordinator: self),
            navigationPropagation: NavigationPropagation()
        )
        let hostingController = HostingController(navigationPropagation: view.navigationPropagation) { view }
        pushViewController(hostingController, animated: true)
    }
}

extension MainCoordinator: NewSportPerformanceListCoordinatorDelegate {

    func finishNewSportPerformance() {
        cancel()
    }
}
