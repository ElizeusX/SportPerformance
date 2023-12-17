//
//  NewSportPerformanceView.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import SwiftUI

struct NewSportPerformanceView: View {

    @StateObject private var viewModel: NewSportPerformanceViewModel
    private let progressHudBinding: ProgressHudBinding
    let navigationPropagation: NavigationPropagation

    // MARK: Init
    init(
        viewModel: NewSportPerformanceViewModel,
        navigationPropagation: NavigationPropagation
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.progressHudBinding = ProgressHudBinding(state: viewModel.$progressHudState)
        self.navigationPropagation = navigationPropagation
        self.navigationPropagation.screenTitleSubject.send(L.NewSportPerformance.title.string())
    }

    // MARK: Body
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: Padding.big) {
                    textFields
                    timePicker
                }
                .padding(EdgeInsets(
                    top: Padding.big,
                    leading: 0,
                    bottom: Padding.huge,
                    trailing: 0
                ))
                Spacer()
            }
            primaryButton
        }
        .actionSheet(isPresented: $viewModel.showSaveSelection, content: {
            ActionSheet(
                title: Text(L.NewSportPerformance.actionSheetTitle),
                message: Text(L.NewSportPerformance.actionSheetMessage),
                buttons: [
                    .default(Text(L.NewSportPerformance.actionSheetLocallyButtonTitle), action: viewModel.savePerformanceLocal),
                    .default(Text(L.NewSportPerformance.actionSheetRemotelyButtonTitle), action: viewModel.savePerformanceRemotely),
                    .cancel()
                ]
            )
        })
        .alert(item: $viewModel.alertConfig) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.message)
            )
        }
    }
}

// MARK: - Components
private extension NewSportPerformanceView {
    var textFields: some View {
        ForEach(PerformanceTextFieldType.allCases, id: \.self) { type in
            PrimaryTextField(
                title: type.title,
                placeholder: type.placeholder,
                getText: viewModel.getTextFieldText(for: type),
                setText: { viewModel.setTextFieldText(for: type, text: $0) },
                warningMessage: { viewModel.getTextFieldWarningMessage(for: type) }
            )
        }
    }
    var timePicker: TimePicker {
        TimePicker(
            selectedHours: $viewModel.selectedHours,
            selectedMinutes: $viewModel.selectedMinutes,
            selectedSeconds: $viewModel.selectedSeconds,
            warningMessage: viewModel.warningMessageForDuration
        )
    }
    var primaryButton: PrimaryButton {
        PrimaryButton(
            title: L.NewSportPerformance.primaryButtonTitle.string(),
            icon: Icons.plusSquare,
            action: viewModel.primaryButtonAction
        )
    }
}

// MARK: - Preview
#Preview {
    NewSportPerformanceView(
        viewModel: NewSportPerformanceViewModel(
            coordinator: nil,
            firebaseStoreManager: MockFirebaseStoreManager(),
            dataPersistenceManager: MockDataPersistenceManager(),
            delegate: nil
        ),
        navigationPropagation: NavigationPropagation()
    )
}
