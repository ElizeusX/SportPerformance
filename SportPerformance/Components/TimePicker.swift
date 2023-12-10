//
//  TimePicker.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 10.12.2023.
//

import SwiftUI

struct TimePicker: View {

    enum Time: String, CaseIterable {
        case hours = "Hours"
        case minutes = "Minutes"
        case seconds = "Seconds"

        var range: Range<Int> {
            switch self {
            case .hours:
                0..<24
            case .minutes, .seconds:
                0..<60
            }
        }
        var shortName: String {
            switch self {
            case .hours:
                "hr"
            case .minutes:
                "min"
            case .seconds:
                "sec"
            }
        }
    }

    @Binding private var selectedHours: Int
    @Binding private var selectedMinutes: Int
    @Binding private var selectedSeconds: Int

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
                ForEach(Time.allCases, id: \.self) { type in
                    Picker(type.rawValue, selection: setSelection(for: type)) {
                        ForEach(type.range, id: \.self) { time in
                            Text("\(time) \(type.shortName)")
                                .tag(time)
                        }
                    }
                }
            }
//            HStack {
//                Picker("Hours", selection: $selectedHours) {
//                    ForEach(0..<24) { hour in
//                        Text("\(hour) hr")
//                            .tag(hour)
//                    }
//                }
//                Picker("Minutes", selection: $selectedMinutes) {
//                    ForEach(0..<60) { minute in
//                        Text("\(minute) min")
//                            .tag(minute)
//                    }
//                }
//                Picker("Seconds", selection: $selectedSeconds) {
//                    ForEach(0..<60) { second in
//                        Text("\(second) sec")
//                            .tag(second)
//                    }
//                }
//            }
            .pickerStyle(WheelPickerStyle())
        }
        .padding(.horizontal, Constraints.Padding.medium)
    }

    private func setSelection(for time: Time) -> Binding<Int> {
        switch time {
        case .hours:
            $selectedHours
        case .minutes:
            $selectedMinutes
        case .seconds:
            $selectedSeconds
        }
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
