//
//  PersistentManager.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 14.12.2023.
//

import UIKit
import CoreData

protocol DataPersistenceManagerProtocol {
    func savePerformance(performance: PerformanceEntityStub) throws
    func getPerformanceCollection() throws -> [PerformanceModel]
    func deletePerformance(with id: String) throws
}

final class DataPersistenceManager: DataPersistenceManagerProtocol {

    private let appDelegate = UIApplication.shared.delegate as? AppDelegate

    func savePerformance(performance: PerformanceEntityStub) throws {
        guard let context = appDelegate?.persistentContainer.viewContext else {
            preconditionFailure("context must exist")
        }

        let newPerformance = PerformanceEntity(context: context)
        newPerformance.id = UUID().uuidString
        newPerformance.name = performance.name
        newPerformance.place = performance.place
        newPerformance.duration = performance.duration
        newPerformance.date = Date.now

        do {
            try context.save()
        } catch {
            throw DataPersistenceError.errorSavingData
        }
    }

    func getPerformanceCollection() throws -> [PerformanceModel] {
        guard let context = appDelegate?.persistentContainer.viewContext else {
            preconditionFailure("context must exist")
        }
        let fetchRequest = NSFetchRequest<PerformanceEntity>(entityName: "PerformanceEntity")

        do {
            return try context.fetch(fetchRequest).compactMap { performance in
                PerformanceModel(
                    id: performance.id ?? UUID().uuidString,
                    name: performance.name ?? EmptyState.emptyStateString,
                    place: performance.place ?? EmptyState.emptyStateString,
                    duration: performance.duration ?? EmptyState.emptyStateString,
                    date: performance.date ?? Date(),
                    repository: .local
                )
            }
        } catch {
            throw DataPersistenceError.errorLoadingData
        }
    }

    func deletePerformance(with id: String) throws {
        guard let context = appDelegate?.persistentContainer.viewContext else {
            preconditionFailure("context must exist")
        }
        let fetchRequest: NSFetchRequest<PerformanceEntity> = PerformanceEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [id])

        do {
            let performances = try context.fetch(fetchRequest)

            guard let performance = performances.first else {
                assertionFailure("Performance with ID \(id) not found.")
                throw DataPersistenceError.errorDeletingData
            }

            context.delete(performance)
            try context.save()
        } catch {
            throw DataPersistenceError.errorDeletingData
        }
    }
}
