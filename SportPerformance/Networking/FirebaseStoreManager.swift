//
//  FirebaseStoreService.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 12.12.2023.
//

import Foundation
import FirebaseFirestore

protocol FirebaseStoreManagerProtocol {
    func addPerformance(
        performance: FirebasePerformanceModel,
        completion: @escaping (Result<Void, Error>) -> Void
    )
    func getPerformanceCollection() async throws -> [PerformanceModel]
    func deletePerformance(with id: String) async throws
}

final class FirebaseStoreManager: FirebaseStoreManagerProtocol {

    private let firestore = Firestore.firestore()
    private let performanceCollection = "SportsPerformance"

    // MARK: Methods
    func addPerformance(
        performance: FirebasePerformanceModel,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        do {
            try firestore
                .collection(performanceCollection)
                .addDocument(from: performance) { error in
                    if let error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
        } catch {
            completion(.failure(error))
        }
    }

    func getPerformanceCollection() async throws -> [PerformanceModel] {
            let snapshot = try await firestore
                .collection(performanceCollection)
                .getDocuments()
        guard !snapshot.isEmpty else { return [] }
        return try snapshot.documents.compactMap { try $0.data(as: FirebasePerformanceModel.self).internalModel }
    }

    func deletePerformance(with id: String) async throws {
        try await firestore
            .collection(performanceCollection)
            .document(id)
            .delete()
    }
}
