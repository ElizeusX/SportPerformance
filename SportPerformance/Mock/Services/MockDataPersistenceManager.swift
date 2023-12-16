//
//  MockDataPersistenceManager.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 15.12.2023.
//

import Foundation

class MockDataPersistenceManager: DataPersistenceManagerProtocol {

    func savePerformance(performance: PerformanceModel) throws {
    }
    
    func getPerformanceCollection() throws -> [PerformanceModel] {
        MockData.performanceData
    }
    
    func deletePerformance(with id: String) throws {
    }
}
