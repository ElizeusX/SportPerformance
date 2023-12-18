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
        static let allTitle: LocalizedStringResource = "All"
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

    enum SportPerformanceList {
        static let title: LocalizedStringResource = "Sports Performance"
        static let emptyStateTitle: LocalizedStringResource = "Not found"
        static let emptyStateMessage: LocalizedStringResource = "The sports performance data is not found."
        static let repositorySegmentPickerText: LocalizedStringResource = "Select repository"
        static let deleteActionTitle: LocalizedStringResource = "Delete"
        static let primaryButtonTitle: LocalizedStringResource = "Add new"
    }

    enum TimePicker {
        static let title: LocalizedStringResource = "Duration:"
        static let hoursPickerText: LocalizedStringResource = "Hours"
        static let hoursShortText: LocalizedStringResource = "hr"
        static let minutesPickerText: LocalizedStringResource = "Hours"
        static let minutesShortText: LocalizedStringResource = "hr"
        static let secondsPickerText: LocalizedStringResource = "Hours"
        static let secondsShortText: LocalizedStringResource = "hr"
    }
}
