//
//  MainCoordinator.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 07.12.2023.
//

import SwiftUI

class MainCoordinator: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setViewControllers(
            [
                UIHostingController(rootView: PerformanceListView(
                    viewModel: PerformanceListViewModel()
                ))
            ],
            animated: false
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
