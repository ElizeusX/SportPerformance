//
//  Repository.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 16.12.2023.
//

import SwiftUI

enum Repository: Codable {
    case local
    case remote

    var icon: Image {
        switch self {
        case .local:
            Icons.local
        case .remote:
            Icons.remote
        }
    }
    var color: Color {
        switch self {
        case .local:
                .gray.opacity(0.7)
        case .remote:
                .blue.opacity(0.7)
        }
    }
    var title: String {
        switch self {
        case .local:
            L.Repository.localTitle.string()
        case .remote:
            L.Repository.remoteTitle.string()
        }
    }
}
