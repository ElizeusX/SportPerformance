//
//  MainCoordinatorDelegates.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import Foundation

protocol PerformanceListCoordinatorDelegate: AnyObject {
    func goToNewSportPerformance(delegate: NewSportPerformanceDelegate)
}

protocol NewSportPerformanceListCoordinatorDelegate: AnyObject {
    func finishNewSportPerformance()
}
