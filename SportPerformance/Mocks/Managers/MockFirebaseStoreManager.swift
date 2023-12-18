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
        MockData.performanceData.filter { $0.repository == .remote }
    }

    func deletePerformance(with id: String) async throws {
    }
}

final class MockFirebaseStoreManagerWithError: FirebaseStoreManagerProtocol {

    func addPerformance(performance: FirebasePerformanceModel, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.failure(GenericError.unexpectedError))
    }

    func getPerformanceCollection() async throws -> [PerformanceModel] {
        throw GenericError.unexpectedError
    }

    func deletePerformance(with id: String) async throws {
        throw GenericError.unexpectedError
    }
}
