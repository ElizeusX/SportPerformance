//
//  PerformanceModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import Foundation

struct PerformanceModel: Codable, Equatable {
    let id: String
    let name: String
    let place: String
    let duration: String
    let date: Date
    let repository: Repository
}
