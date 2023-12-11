//
//  NewSportPerformanceViewModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 10.12.2023.
//

import Foundation

class NewSportPerformanceViewModel: ObservableObject {

    @Published var name = ""
    @Published var place = ""
    @Published var selectedHours = 0
    @Published var selectedMinutes = 0
    @Published var selectedSeconds = 0


    // MARK: Methods
    func createSportPerformance() {
        // TODO: Name, place, duration and save to remote or local
    }

    // MARK: Private methods
    private func getDuration() -> String {
        var dateComponents = DateComponents()
        dateComponents.hour = selectedHours
        dateComponents.minute = selectedMinutes
        dateComponents.second = selectedSeconds
        guard let date = Calendar.current.date(from: dateComponents) else { return "" /*error handler*/ }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
}
