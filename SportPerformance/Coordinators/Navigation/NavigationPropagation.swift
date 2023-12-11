//
//  NavigationPropagation.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 11.12.2023.
//

import Combine
import SwiftUI

class NavigationPropagation {
    let leadingNavigationButtonsSubject: CurrentValueSubject<[UIBarButtonItem], Never>
    let screenTitleSubject: CurrentValueSubject<String?, Never>

    init(
        screenTitle: String? = nil,
        leadingNavigationButtons: [UIBarButtonItem] = []
    ) {
        self.screenTitleSubject = CurrentValueSubject(screenTitle)
        self.leadingNavigationButtonsSubject = CurrentValueSubject(leadingNavigationButtons)
    }
}
