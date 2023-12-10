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

    init(
        title: String,
        placeholder: String,
        text: Binding<String>
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
            TextField(text: $text) {
                Text(placeholder)
            }
            Divider()
                .background(Color.black)
        }
        .padding(.horizontal, Constraints.Padding.medium)
    }
}

#Preview {
    PrimaryTextField(
        title: "Name:",
        placeholder: "Running",
        text: .constant("")
    )
}
