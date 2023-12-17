//
//  MockData.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import Foundation

enum MockData {
    static let performanceData = [
        PerformanceModel(
            id: UUID().uuidString,
            name: "Name",
            place: "Place",
            duration: "Duration",
            date: Date.now,
            repository: .remote
        ),
        PerformanceModel(
            id: UUID().uuidString,
            name: "Name",
            place: "Place",
            duration: "Duration",
            date: Date.now,
            repository: .local
        )
    ]
}
