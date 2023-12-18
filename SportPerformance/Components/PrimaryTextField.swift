//
//  PrimaryTextField.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 10.12.2023.
//

import SwiftUI

struct PrimaryTextField: View {

    private let title: String
    private let placeholder: String
    @Binding private var text: String
    private let warningMessage: () -> String

    var showWarning: Bool {
        !warningMessage().isEmpty && text.isEmpty
    }

    // MARK: Init
    init(
        title: String,
        placeholder: String,
        getText: String,
        setText: @escaping (_ text: String) -> Void,
        warningMessage: @escaping () -> String = { "" }

    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = Binding(
            get: { getText },
            set: { setText($0) }
        )
        self.warningMessage = warningMessage
    }

    // MARK: Body
    var body: some View {
        VStack(alignment: .leading) {
            textField
            warning
        }
        .padding(.horizontal, Padding.medium)
        .animation(.easeInOut, value: showWarning)
    }
}

// MARK: - Components
private extension PrimaryTextField {
    var textField: some View {
        VStack(alignment: .leading)  {
            Text(title)
                .font(.caption)
            TextField(placeholder, text: $text)
                .autocorrectionDisabled()
            Divider()
                .background(Color.black)
        }
        .background(showWarning ? Color.red.opacity(0.2) : Color.clear)
    }
    var warning: WarningMessage {
        WarningMessage(
            warningMessage: warningMessage(),
            showWarning: showWarning
        )
    }
}

// MARK: - Preview
#Preview {
    PrimaryTextField(
        title: "Name:",
        placeholder: "Running",
        getText: "",
        setText: { _ in },
        warningMessage: { "" }
    )
}
