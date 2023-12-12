//
//  FirebasePerformanceModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 12.12.2023.
//

import Foundation
import FirebaseFirestoreSwift

struct FirebasePerformanceModel: Codable {
    @DocumentID var id: String?
    let name: String
    let place: String
    let duration: String
    let date: Date

    var internalModel: PerformanceModel {
        guard let id else {
            preconditionFailure("There has to be performance id.")
        }
        return PerformanceModel(
            id: id,
            name: name,
            place: place,
            duration: duration,
            date: date,
            repository: .remote
        )
    }
}
