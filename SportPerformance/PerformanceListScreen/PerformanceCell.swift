//
//  PerformanceCell.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 08.12.2023.
//

import SwiftUI

// MARK: - ViewModel
class PerformanceCellViewModel {

    enum Repository {
        case local
        case remote

        var icon: String {
            switch self {
            case .local:
                return "internaldrive.fill"
            case .remote:
                return "externaldrive.fill.badge.icloud"
            }
        }
        var color: Color {
            switch self {
            case .local:
                return .black
            case .remote:
                return .blue
            }
        }
    }

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
        HStack(alignment: .center, spacing: Constraints.Padding.standard) {
            Image(systemName: viewModel.repository.icon)
                .foregroundColor(viewModel.repository.color)
            Divider()
                .background(Color.black)
                .padding(.vertical, Constraints.Padding.small)
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.headline)
                Text(viewModel.place)
                Text(viewModel.time)
            }
            .font(.subheadline)
            Spacer()
        }
        .padding(.horizontal, Constraints.Padding.standard)
        .frame(height: 75)
        Divider()
    }
}

// MARK: - Preview
#Preview {
    VStack {
        PerformanceCell(
            viewModel: PerformanceCellViewModel(
                name: "Name",
                place: "Description",
                time: "Time",
                fromRepository: .remote
            )
        )
        PerformanceCell(
            viewModel: PerformanceCellViewModel(
                name: "Name",
                place: "Description",
                time: "Time",
                fromRepository: .local
            )
        )
    }
    .previewLayout(.sizeThatFits)
}
