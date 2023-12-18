//
//  Repository.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 16.12.2023.
//

import SwiftUI

enum Repository: CaseIterable, Codable {
    case all
    case local
    case remote

    var icon: Image {
        switch self {
        case .local:
            Icons.local
        case .remote:
            Icons.remote
        case .all:
            preconditionFailure("Not used")
        }
    }
    var color: Color {
        switch self {
        case .local:
                .gray.opacity(0.7)
        case .remote:
                .blue.opacity(0.7)
        case .all:
            preconditionFailure("Not used")
        }
    }
    var title: String {
        switch self {
        case .local:
            L.Repository.localTitle.string()
        case .remote:
            L.Repository.remoteTitle.string()
        case .all:
            L.Repository.allTitle.string()
        }
    }
}
