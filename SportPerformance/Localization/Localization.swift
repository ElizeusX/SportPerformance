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
        static let genericErrorTitle = LocalizedStringResource("Error")
        static let genericErrorMessage = LocalizedStringResource("Unexpected error occured. Please try again later.")
    }

}
