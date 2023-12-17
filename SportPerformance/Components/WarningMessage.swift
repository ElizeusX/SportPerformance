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

    init(
        warningMessage: String,
        showWarning: Bool
    ) {
        self.warningMessage = warningMessage
        self.showWarning = showWarning
    }

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

#Preview {
    WarningMessage(
        warningMessage: "Warning message",
        showWarning: true
    )
}
