//
//  Practice+CoreDataProperties.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 17/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//
//

import Foundation
import CoreData


extension Practice {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Practice> {
        return NSFetchRequest<Practice>(entityName: "Practice")
    }

    @NSManaged public var id: UUID
    @NSManaged public var keynoteName: URL
    @NSManaged public var keynotePreview: URL
    @NSManaged public var maxDuration: Int32
    @NSManaged public var totalTime: Int32
    @NSManaged public var slides: NSSet

}

// MARK: Generated accessors for slides
extension Practice {

    @objc(addSlidesObject:)
    @NSManaged public func addToSlides(_ value: Slide)

    @objc(removeSlidesObject:)
    @NSManaged public func removeFromSlides(_ value: Slide)

    @objc(addSlides:)
    @NSManaged public func addToSlides(_ values: NSSet)

    @objc(removeSlides:)
    @NSManaged public func removeFromSlides(_ values: NSSet)

}
