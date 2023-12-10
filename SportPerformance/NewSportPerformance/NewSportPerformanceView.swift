//
//  NewSportPerformanceView.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import SwiftUI

struct NewSportPerformanceView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: Constraints.Padding.medium) {
                    nameTextField
                    placeTextField
                    timePicker
                }
                .padding(.vertical, 100)
                Spacer()
            }
            primaryButton
        }
    }
}

// MARK: - Components
private extension NewSportPerformanceView {
    var nameTextField: PrimaryTextField {
        PrimaryTextField(
            title: "Name:",
            placeholder: "Running",
            text: .constant("") // TODO
        )
    }
    var placeTextField: PrimaryTextField {
        PrimaryTextField(
            title: "Place:",
            placeholder: "Stadium",
            text: .constant("") // TODO
        )
    }
    var timePicker: TimePicker {
        TimePicker(
            selectedHours: .constant(0),  // TODO
            selectedMinutes: .constant(0), // TODO
            selectedSeconds: .constant(0) // TODO
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
    NewSportPerformanceView()
}
