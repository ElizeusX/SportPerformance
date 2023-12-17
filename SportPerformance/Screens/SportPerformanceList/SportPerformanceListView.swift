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
        .alert(item: $viewModel.alertConfig) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.message)
            )
        }
    }
}

// MARK: - Components
private extension SportPerformanceListView {
    var performanceList: some View {
        List {
            ForEach(viewModel.performanceCollection, id: \.id) { item in
                PerformanceCell(
                    viewModel: PerformanceCellViewModel(
                        name: item.name,
                        place: item.place,
                        time: item.duration,
                        fromRepository: item.repository
                    )
                ).swipeActions(edge: .trailing) {
                    Button {
                        withAnimation {
                            viewModel.deletePerformance(
                                with: item.id,
                                for: item.repository
                            )
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                    .frame(height: 75)
                }
            }
            .listRowSeparator(.hidden)
        }
        .padding(.bottom, Padding.huge)
        .listStyle(PlainListStyle())
    }
    var primaryButton: PrimaryButton {
        PrimaryButton(
            title: "Add new",
            icon: Icons.runSquare,
            action: viewModel.goToNewSportPerformance
        )
    }
}

// MARK: - Preview
#Preview {
    SportPerformanceListView(
        viewModel: SportPerformanceListViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager()
        ),
        navigationPropagation: NavigationPropagation()
    )
}
