//
//  MockDataPersistenceManager.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 15.12.2023.
//

import Foundation

class MockDataPersistenceManager: DataPersistenceManagerProtocol {

    func savePerformance(performance: PerformanceEntityStub) throws {
    }
    
    func getPerformanceCollection() throws -> [PerformanceModel] {
        MockData.performanceData.filter { $0.repository == .local }
    }
    
    func deletePerformance(with id: String) throws {
    }
}

class MockDataPersistenceManagerWithError: DataPersistenceManagerProtocol {

    func savePerformance(performance: PerformanceEntityStub) throws {
        throw GenericError.unexpectedError
    }

    func getPerformanceCollection() throws -> [PerformanceModel] {
        throw GenericError.unexpectedError
    }

    func deletePerformance(with id: String) throws {
        throw GenericError.unexpectedError
    }
}
