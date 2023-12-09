//
//  PerformanceListViewModel.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 09.12.2023.
//

import Foundation

class PerformanceListViewModel: ObservableObject {
    
    @Published var performanceData: [PerformanceModel] = MockData.performanceData
}
