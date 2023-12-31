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
        self.navigationPropagation.screenTitleSubject.send(L.SportPerformanceList.title.string())
    }

    // MARK: Body
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                repositorySegmentPicker
                if viewModel.showEmptyState {
                    emptyState
                } else {
                    performanceList
                }
            }
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
    var repositorySegmentPicker: some View {
        Picker(
            L.SportPerformanceList.repositorySegmentPickerText.string(),
            selection: $viewModel.selectedRepository
        ) {
            ForEach(Repository.allCases, id: \.self) { type in
                Text(type.title).tag(type)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, Padding.medium)
    }
    var emptyState: EmptyStateView {
        EmptyStateView(
            title: L.SportPerformanceList.emptyStateTitle,
            message: L.SportPerformanceList.emptyStateMessage
        )
    }
    var performanceList: some View {
        List {
            ForEach(viewModel.filteredPerformanceCollection, id: \.id) { item in
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
                        Label(
                            L.SportPerformanceList.deleteActionTitle.string(),
                            systemImage: "trash"
                        )
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
            title: L.SportPerformanceList.primaryButtonTitle.string(),
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
