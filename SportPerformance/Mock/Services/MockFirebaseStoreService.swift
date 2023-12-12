//
//  MockFirebaseStoreService.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 12.12.2023.
//

import Foundation

final class MockFirebaseStoreService: FirebaseStoreServiceProtocol {

    func addPerformance(performance: FirebasePerformanceModel, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
    
    func getPerformanceCollection() async throws -> [PerformanceModel] {
        MockData.performanceData
    }
}
