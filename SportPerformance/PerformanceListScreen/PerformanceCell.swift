//
//  PerformanceCell.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 08.12.2023.
//

import SwiftUI

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
    let description: String
    let time: String
    let repository: Repository

    init(
        name: String,
        description: String,
        time: String,
        fromRepository: Repository
    ) {
        self.name = name
        self.description = description
        self.time = time
        self.repository = fromRepository
    }

}

struct PerformanceCell: View {

    let viewModel: PerformanceCellViewModel

    init(viewModel: PerformanceCellViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: viewModel.repository.icon)
                .foregroundColor(viewModel.repository.color)

            Divider()
                .background(Color.black)
                .padding(.vertical, 8)

            VStack(alignment: .leading) {
                Text("Name")
                    .font(.headline)
                Text("Description")
                    .font(.subheadline)
                Text("Time")
                    .font(.subheadline)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 80)
        Divider()
    }
}

#Preview {
    PerformanceCell(
        viewModel: PerformanceCellViewModel(
            name: "Name",
            description: "Description",
            time: "Time",
            fromRepository: .remote
        )
    )
    .previewLayout(.sizeThatFits)
}
