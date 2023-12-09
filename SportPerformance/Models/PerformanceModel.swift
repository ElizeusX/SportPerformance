//
//  PerformanceModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import Foundation

struct PerformanceModel: Codable {
    let id: UUID
    let name: String
    let place: String
    let duration: String
    let repository: Repository
}
