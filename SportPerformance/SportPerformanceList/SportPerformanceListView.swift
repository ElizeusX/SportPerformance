//
//  SportPerformanceListView.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 07.12.2023.
//

import SwiftUI

struct SportPerformanceListView: View {

    @StateObject private var viewModel: SportPerformanceListViewModel
    private let progressHudBinding: ProgressHudBinding
    let navigationPropagation: NavigationPropagation

    // MARK: Init
    init(
        viewModel: SportPerformanceListViewModel,
        navigationPropagation: NavigationPropagation
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.progressHudBinding = ProgressHudBinding(state: viewModel.$progressHudState)
        self.navigationPropagation = navigationPropagation
        self.navigationPropagation.screenTitleSubject.send("Sports Performance")
    }

    // MARK: Body
    var body: some View {
        ZStack(alignment: .bottom) {
            performanceList
            primaryButton
        }
    }
}

// MARK: - Components
private extension SportPerformanceListView {
    var performanceList: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.performanceCollection, id: \.id) { item in
                    PerformanceCell(
                        viewModel: PerformanceCellViewModel(
                            name: item.name,
                            place: item.place,
                            time: item.duration,
                            fromRepository: item.repository
                        )
                    )
                }
            }
        }
    }
    var primaryButton: PrimaryButton {
        PrimaryButton(
            title: "Add new",
            icon: Image(systemName: "figure.run.square.stack"),
            action: viewModel.goToNewSportPerformance
        )
    }
}

// MARK: - Preview
#Preview {
    SportPerformanceListView(
        viewModel: SportPerformanceListViewModel(
            coordinator: nil,
            firebaseStoreService: MockFirebaseStoreService()
        ),
        navigationPropagation: NavigationPropagation()
    )
}
