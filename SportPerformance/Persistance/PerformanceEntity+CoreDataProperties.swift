//
//  PerformanceEntity+CoreDataProperties.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 16.12.2023.
//
//

import Foundation
import CoreData


extension PerformanceEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PerformanceEntity> {
        return NSFetchRequest<PerformanceEntity>(entityName: "PerformanceEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var place: String?
    @NSManaged public var duration: String?
    @NSManaged public var date: Date?

}

extension PerformanceEntity : Identifiable {

}
