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
                UIHostingController(rootView: PerformanceListView(
                    viewModel: PerformanceListViewModel(coordinator: self)
                ))
            ],
            animated: false
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Delegates
extension MainCoordinator: PerformanceListCoordinatorDelegate {

    func goToNewSportPerformance() {
        // TODO: Add view to new sports performance
    }
}
