//
//  PersistentManager.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 14.12.2023.
//

import UIKit
import CoreData

enum DataPersistenceError: Error {
    case errorSavingData
    case errorLoadingData
    case errorDeletingData

    var title: String {
        switch self {
        case .errorSavingData:
            L.Errors.errorSavingDataTitle.string()
        case .errorLoadingData:
            L.Errors.errorLoadingDataTitle.string()
        case .errorDeletingData:
            L.Errors.errorDeletingDataTitle.string()
        }
    }
    var message: String {
        switch self {
        case .errorSavingData:
            L.Errors.errorSavingDataMessage.string()
        case .errorLoadingData:
            L.Errors.errorLoadingDataMessage.string()
        case .errorDeletingData:
            L.Errors.errorDeletingDataMessage.string()
        }
    }
}

protocol DataPersistenceManagerProtocol {
    func savePerformance(performance: PerformanceModel) throws
    func getPerformanceCollection() throws -> [PerformanceModel]
    func deletePerformance(with id: String) throws
}

final class DataPersistenceManager: DataPersistenceManagerProtocol {

    private let appDelegate = UIApplication.shared.delegate as? AppDelegate

    func savePerformance(performance: PerformanceModel) throws {
        guard let context = appDelegate?.persistentContainer.viewContext else {
            preconditionFailure("context must exist")
        }

        let newPerformance = PerformanceEntity(context: context)
        newPerformance.id = performance.id
        newPerformance.name = performance.name
        newPerformance.place = performance.place
        newPerformance.date = performance.date

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
