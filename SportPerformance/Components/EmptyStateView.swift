//
//  EmptyStateView.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 18.12.2023.
//

import SwiftUI

struct EmptyStateView: View {

    private let title: LocalizedStringResource
    private let message: LocalizedStringResource

    // MARK: Init
    init(
        title: LocalizedStringResource,
        message: LocalizedStringResource
    ) {
        self.title = title
        self.message = message
    }

    // MARK: Body
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.top, Padding.huge)
            Text(message)
                .font(.subheadline)
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    EmptyStateView(
        title: "Not found",
        message: "The sports performances data is not found."
    )
}
