//
//  PerformanceListView.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 07.12.2023.
//

import SwiftUI

struct PerformanceListView: View {

    @StateObject private var viewModel: PerformanceListViewModel

    // MARK: Init
    init(viewModel: PerformanceListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: Body
    var body: some View {
        Text("Sports Performance")
        ZStack(alignment: .bottom) {
            performanceList
            mainButton
        }
    }
}

// MARK: - Components
private extension PerformanceListView {
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
    var mainButton: some View {
        Button(action: viewModel.goToNewSportPerformance, label: {
            Spacer()
            HStack {
                Text("Add new")
                Image(systemName: "figure.run.square.stack")
            }
            .foregroundColor(.green.opacity(0.9))
            .frame(height: 50)
            Spacer()
        })
        .background(Color.black.opacity(0.9))
        .clipShape(.capsule)
        .padding(EdgeInsets(
            top: 0,
            leading: Constraints.Padding.medium,
            bottom: Constraints.Padding.standard,
            trailing: Constraints.Padding.medium
        ))
    }
}

// MARK: - Preview
#Preview {
    PerformanceListView(
        viewModel: PerformanceListViewModel(coordinator: nil)
    )
}
