//
//  Localization.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 14.12.2023.
//

import Foundation

typealias L = LocalizedString

extension LocalizedStringResource {

    func string() -> String {
        Bundle.main.localizedString(forKey: self.key, value: nil, table: nil)
    }
}

enum LocalizedString {

    enum Errors {
        static let genericErrorTitle: LocalizedStringResource = "Error"
        static let genericErrorMessage: LocalizedStringResource = "Unexpected error occured. Please try again later."
        static let errorSavingDataTitle: LocalizedStringResource = "Failed to save data"
        static let errorSavingDataMessage: LocalizedStringResource = "An error occurred while trying to save the data locally. Please try again later."
        static let errorLoadingDataTitle: LocalizedStringResource = "Failed to delete data"
        static let errorLoadingDataMessage: LocalizedStringResource = "An error occurred while trying to load the data locally. Please try again later."
        static let errorDeletingDataTitle: LocalizedStringResource = "Failed to delete data"
        static let errorDeletingDataMessage: LocalizedStringResource = "An error occurred while trying to delete the data from your device. Please try again later."
    }

    enum Repository {
        static let localTitle: LocalizedStringResource = "Local"
        static let remoteTitle: LocalizedStringResource = "Remote"
    }

    enum NewSportPerformance {
        static let title: LocalizedStringResource = "New Sport Performance"
        static let textFieldNameTitle: LocalizedStringResource = "Name:"
        static let textFieldPlaceTitle: LocalizedStringResource = "Place:"
        static let textFieldNamePlaceholder: LocalizedStringResource = "Running"
        static let textFieldPlacePlaceholder: LocalizedStringResource = "Stadium"
        static let textFieldNameWarningMessage: LocalizedStringResource = "Cannot be added without name"
        static let textFieldPlaceWarningMessage: LocalizedStringResource = "Cannot be added without place"
        static let actionSheetTitle: LocalizedStringResource = "Save Options"
        static let actionSheetMessage: LocalizedStringResource = "Remote saving means that your data will be accessible to others"
        static let actionSheetLocallyButtonTitle: LocalizedStringResource = "Save Locally"
        static let actionSheetRemotelyButtonTitle: LocalizedStringResource = "Save Remotely"
        static let durationWarningMessage: LocalizedStringResource = "Select the duration"
        static let primaryButtonTitle: LocalizedStringResource = "Add"
    }

}
