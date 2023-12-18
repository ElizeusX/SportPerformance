//
//  RepositoryLabel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 16.12.2023.
//

import SwiftUI

struct RepositoryLabel: View {
    
    private let repository: Repository

    // MARK: Init
    init(for repository: Repository) {
        self.repository = repository
    }

    // MARK: Body
    var body: some View {
        HStack(spacing: Padding.small) {
            repository.icon
            Text(repository.title).bold()
        }
        .font(.caption2)
        .padding(EdgeInsets(
            top: 4,
            leading: Padding.small,
            bottom: 4,
            trailing: Padding.small
        ))
        .foregroundStyle(.background)
        .background(Color(repository.color))
        .clipShape(.capsule)
        .frame(alignment: .leading)
    }
}

// MARK: - Preview
#Preview {
    VStack {
        RepositoryLabel(for: .local)
        RepositoryLabel(for: .remote)
    }
}
