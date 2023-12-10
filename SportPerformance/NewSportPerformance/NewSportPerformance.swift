//
//  NewSportPerformance.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import SwiftUI

struct NewSportPerformance: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            primaryButton
        }
    }
}

// MARK: - Components
private extension NewSportPerformance {
    var primaryButton: PrimaryButton {
        PrimaryButton(
            title: "Add",
            icon: Image(systemName: "plus.square.on.square"),
            action: {}
        )
    }
}

// MARK: - Preview
#Preview {
    NewSportPerformance()
}
