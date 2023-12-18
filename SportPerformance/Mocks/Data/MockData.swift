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
            name: "Name1",
            place: "Place",
            duration: "Duration",
            date: Date.now,
            repository: .remote
        ),
        PerformanceModel(
            id: UUID().uuidString,
            name: "Name2",
            place: "Place",
            duration: "Duration",
            date: Date.now + 1,
            repository: .local
        )
    ]
}
