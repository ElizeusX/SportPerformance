//
//  NewSportPerformanceView.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import SwiftUI

struct NewSportPerformanceView: View {

    @StateObject private var viewModel: NewSportPerformanceViewModel
    let navigationPropagation: NavigationPropagation

    // MARK: Init
    init(
        viewModel: NewSportPerformanceViewModel,
        navigationPropagation: NavigationPropagation
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.navigationPropagation = navigationPropagation
        self.navigationPropagation.screenTitleSubject.send("New Sport Performance")
    }

    // MARK: Body
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
            text: $viewModel.name
        )
    }
    var placeTextField: PrimaryTextField {
        PrimaryTextField(
            title: "Place:",
            placeholder: "Stadium",
            text: $viewModel.place
        )
    }
    var timePicker: TimePicker {
        TimePicker(
            selectedHours: $viewModel.selectedHours,
            selectedMinutes: $viewModel.selectedMinutes,
            selectedSeconds: $viewModel.selectedSeconds
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
    NewSportPerformanceView(
        viewModel: NewSportPerformanceViewModel(),
        navigationPropagation: NavigationPropagation()
    )
}
