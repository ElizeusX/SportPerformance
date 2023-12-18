//
//  DataPersistenceError.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 17.12.2023.
//

import Foundation

enum DataPersistenceError: Error {
    case errorSavingData
    case errorLoadingData
    case errorDeletingData

    var title: String {
        switch self {
        case .errorSavingData:
            L.Errors.errorSavingDataTitle.string()
        case .errorLoadingData:
            L.Errors.errorLoadingDataTitle.string()
        case .errorDeletingData:
            L.Errors.errorDeletingDataTitle.string()
        }
    }
    var message: String {
        switch self {
        case .errorSavingData:
            L.Errors.errorSavingDataMessage.string()
        case .errorLoadingData:
            L.Errors.errorLoadingDataMessage.string()
        case .errorDeletingData:
            L.Errors.errorDeletingDataMessage.string()
        }
    }
}
