//
//  HostingController.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 11.12.2023.
//

import SwiftUI
import Combine

class HostingController<Content: View>: UIHostingController<Content> {

    var subscriptions = Set<AnyCancellable>()

    init(navigationPropagation: NavigationPropagation = NavigationPropagation(), @ViewBuilder _ view: () -> Content) {
        super.init(rootView: view())

        navigationPropagation.screenTitleSubject
            .sink { [weak self] screenTitle in
                self?.navigationItem.title = screenTitle
            }
            .store(in: &subscriptions)

        navigationPropagation.leadingNavigationButtonsSubject
            .sink { [weak self] leadingButtons in
                self?.navigationItem.leftBarButtonItems = leadingButtons
            }
            .store(in: &subscriptions)
    }

    @MainActor
    dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
