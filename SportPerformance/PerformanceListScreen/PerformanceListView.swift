//
//  PerformanceListView.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 07.12.2023.
//

import SwiftUI

struct PerformanceListView: View {

    @StateObject private var viewModel: PerformanceListViewModel

    init(viewModel: PerformanceListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Text("Sport Performance")
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
}

#Preview {
    PerformanceListView(
        viewModel: PerformanceListViewModel()
    )
}
