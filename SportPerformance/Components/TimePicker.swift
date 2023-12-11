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

    private let hrRange = 0..<24
    private let minOrSecRange = 0..<60

    // MARK: Init
    init(
        selectedHours: Binding<Int>,
        selectedMinutes: Binding<Int>,
        selectedSeconds: Binding<Int>
    ) {
        self._selectedHours = selectedHours
        self._selectedMinutes = selectedMinutes
        self._selectedSeconds = selectedSeconds
    }

    // MARK: Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Duration:")
                .font(.caption)
            HStack {
                Picker("Hours", selection: $selectedHours) {
                    ForEach(hrRange, id: \.self) { hour in
                        Text("\(hour) hr")
                            .tag(hour)
                    }
                }
                Picker("Minutes", selection: $selectedMinutes) {
                    ForEach(minOrSecRange, id: \.self) { minute in
                        Text("\(minute) min")
                            .tag(minute)
                    }
                }
                Picker("Seconds", selection: $selectedSeconds) {
                    ForEach(minOrSecRange, id: \.self) { second in
                        Text("\(second) sec")
                            .tag(second)
                    }
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
        .padding(.horizontal, Constraints.Padding.medium)
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
