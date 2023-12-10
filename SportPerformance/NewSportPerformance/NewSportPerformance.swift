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
            ScrollView {
                VStack(spacing: Constraints.Padding.medium) {
                    nameTextField
                    placeTextField
                }
                Spacer()
            }
            .padding(.top, 100)
            primaryButton
        }
    }
}

// MARK: - Components
private extension NewSportPerformance {
    var nameTextField: some View {
        PrimaryTextField(
            title: "Name:",
            placeholder: "Running",
            text: .constant("") // TODO
        )
    }
    var placeTextField: some View {
        PrimaryTextField(
            title: "Place:",
            placeholder: "Stadium",
            text: .constant("") // TODO
        )
    }
    var primaryButton: PrimaryButton {
        PrimaryButton(
            title: "Add",
            icon: Image(systemName: "plus.square.on.square"),
            action: {} // TODO
        )
    }
}

// MARK: - Preview
#Preview {
    NewSportPerformance()
}
