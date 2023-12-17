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
        Label(
            title: { Text(repository.title).bold() },
            icon: { repository.icon }
        )
        .font(.caption2)
        .padding(.horizontal, Padding.small)
        .padding(4)
        .foregroundStyle(.background)
        .background(Color(repository.color))
        .clipShape(.capsule)
    }
}

#Preview {
    VStack {
        RepositoryLabel(for: .local)
        RepositoryLabel(for: .remote)
    }
}
