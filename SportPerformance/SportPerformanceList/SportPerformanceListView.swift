//
//  SportPerformanceListView.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 07.12.2023.
//

import SwiftUI

struct SportPerformanceListView: View {

    @StateObject private var viewModel: SportPerformanceListViewModel

    // MARK: Init
    init(viewModel: SportPerformanceListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: Body
    var body: some View {
        Text("Sports Performance")
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
                ForEach(viewModel.performanceData, id: \.id) { item in
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
        viewModel: SportPerformanceListViewModel(coordinator: nil)
    )
}
