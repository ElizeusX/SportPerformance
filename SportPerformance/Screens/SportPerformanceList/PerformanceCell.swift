//
//  PerformanceCell.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 08.12.2023.
//

import SwiftUI

// MARK: - ViewModel
class PerformanceCellViewModel {

    let name: String
    let place: String
    let time: String
    let repository: Repository

    // MARK: Init
    init(
        name: String,
        place: String,
        time: String,
        fromRepository: Repository
    ) {
        self.name = name
        self.place = place
        self.time = time
        self.repository = fromRepository
    }
}

// MARK: - View
struct PerformanceCell: View {

    let viewModel: PerformanceCellViewModel

    // MARK: Init
    init(viewModel: PerformanceCellViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Body
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: Padding.standard) {
                leftIcon
                verticalDivider
                infoStack
            }
            Divider()
        }
        .padding(.horizontal, Padding.small)
        .frame(height: 75)
    }
}

// MARK: - Components
private extension PerformanceCell {
    var leftIcon: some View {
        Icons.run
            .resizable()
            .scaledToFill()
            .frame(width: 30, height: 30)
    }
    var verticalDivider: some View {
        Divider()
            .background(Color.black)
            .padding(.vertical, Padding.small)
    }
    var infoStack: some View {
        VStack(alignment: .leading) {
            Text(viewModel.name)
                .font(.headline)
            Text(viewModel.place)
            HStack {
                Text(viewModel.time)
                Spacer()
                RepositoryLabel(for: viewModel.repository)
            }
        }
        .font(.subheadline)
    }
}

// MARK: - Preview
#Preview {
    VStack {
        PerformanceCell(
            viewModel: PerformanceCellViewModel(
                name: "Name",
                place: "Place",
                time: "Time",
                fromRepository: .remote
            )
        )
        PerformanceCell(
            viewModel: PerformanceCellViewModel(
                name: "Name",
                place: "Place",
                time: "Time",
                fromRepository: .local
            )
        )
    }
    .previewLayout(.sizeThatFits)
}
