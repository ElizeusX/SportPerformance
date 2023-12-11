//
//  NewSportPerformanceViewModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 10.12.2023.
//

import Foundation

class NewSportPerformanceViewModel: ObservableObject {

    @Published var name = ""
    @Published var place = ""
    @Published var selectedHours = 0
    @Published var selectedMinutes = 0
    @Published var selectedSeconds = 0

}
