//
//  MockFirebaseStoreManager.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 12.12.2023.
//

import Foundation

final class MockFirebaseStoreManager: FirebaseStoreManagerProtocol {

    func addPerformance(performance: FirebasePerformanceModel, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
    
    func getPerformanceCollection() async throws -> [PerformanceModel] {
        MockData.performanceData
    }

    func deletePerformance(with id: String) async throws {
    }
}
