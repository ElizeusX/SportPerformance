//
//  WarningMessage.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 17.12.2023.
//

import SwiftUI

struct WarningMessage: View {

    private let warningMessage: String
    private let showWarning: Bool

    // MARK: Init
    init(
        warningMessage: String,
        showWarning: Bool
    ) {
        self.warningMessage = warningMessage
        self.showWarning = showWarning
    }

    // MARK: Body
    var body: some View {
        if showWarning {
            HStack {
                Text(warningMessage)
                    .padding(Padding.standard)
                    .font(.caption)
                    .foregroundStyle(.background)
                Spacer()
            }
            .background(.black.opacity(0.8))
            .clipShape(.buttonBorder)
            .transition(.opacity)
        }
    }
}

// MARK: - Preview
#Preview {
    WarningMessage(
        warningMessage: "Warning message",
        showWarning: true
    )
}
