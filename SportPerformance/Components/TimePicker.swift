//
//  TimePicker.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 10.12.2023.
//

import SwiftUI

struct TimePicker: View {

    @Binding private var selectedHours: Int
    @Binding private var selectedMinutes: Int
    @Binding private var selectedSeconds: Int
    private var warningMessage: String = ""

    private let hrRange = 0..<24
    private let minOrSecRange = 0..<60

    var showWarning: Bool {
        !warningMessage.isEmpty && (selectedHours + selectedMinutes + selectedSeconds) == 0
    }

    // MARK: Init
    init(
        selectedHours: Binding<Int>,
        selectedMinutes: Binding<Int>,
        selectedSeconds: Binding<Int>,
        warningMessage: String = ""
    ) {
        self._selectedHours = selectedHours
        self._selectedMinutes = selectedMinutes
        self._selectedSeconds = selectedSeconds
        self.warningMessage = warningMessage
    }

    // MARK: Body
    var body: some View {
        VStack(alignment: .leading) {
            timePicker
            warning
        }
        .padding(.horizontal, Padding.medium)
        .animation(.easeInOut, value: showWarning)
    }
}

// MARK: - Components
private extension TimePicker {
    var timePicker: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(L.TimePicker.title)
                .font(.caption)
            HStack {
                Picker(L.TimePicker.hoursPickerText.string(), selection: $selectedHours) {
                    ForEach(hrRange, id: \.self) { hour in
                        Text("\(hour) \(L.TimePicker.hoursShortText)")
                            .tag(hour)
                    }
                }
                Picker(L.TimePicker.minutesPickerText.string(), selection: $selectedMinutes) {
                    ForEach(minOrSecRange, id: \.self) { minute in
                        Text("\(minute) \(L.TimePicker.minutesShortText)")
                            .tag(minute)
                    }
                }
                Picker(L.TimePicker.secondsPickerText.string(), selection: $selectedSeconds) {
                    ForEach(minOrSecRange, id: \.self) { second in
                        Text("\(second) \(L.TimePicker.secondsShortText)")
                            .tag(second)
                    }
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
        .background(showWarning ? Color.red.opacity(0.2) : Color.clear)
    }
    var warning: WarningMessage {
        WarningMessage(
            warningMessage: warningMessage,
            showWarning: showWarning
        )
    }
}

// MARK: - Preview
#Preview {
    TimePicker(
        selectedHours: .constant(0),
        selectedMinutes: .constant(0),
        selectedSeconds: .constant(0)
    )
}
