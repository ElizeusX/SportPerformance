//
//  PrimaryButton.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 10.12.2023.
//

import SwiftUI

struct PrimaryButton: View {

    let title: String
    let icon: Image?
    let action: () -> Void

    // MARK: Init
    init(
        title: String,
        icon: Image? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.action = action
    }

    // MARK: Body
    var body: some View {
            Button(action: action, label: {
                Spacer()
                HStack {
                    Text(title)
                    icon
                }
                .foregroundColor(.green.opacity(0.9))
                .frame(height: 50)
                Spacer()
            })
            .background(Color.black.opacity(0.9))
            .clipShape(.capsule)
            .padding(EdgeInsets(
                top: 0,
                leading: Padding.big,
                bottom: Padding.standard,
                trailing: Padding.big
            ))
    }
}

// MARK: - Preview
#Preview {
    PrimaryButton(
        title: "Button",
        icon: Icons.runSquare,
        action: {}
    )
}
