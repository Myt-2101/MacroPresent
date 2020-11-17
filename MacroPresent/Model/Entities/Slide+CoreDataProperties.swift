//
//  Slide+CoreDataProperties.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 17/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//
//

import Foundation
import CoreData


extension Slide {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Slide> {
        return NSFetchRequest<Slide>(entityName: "Slide")
    }

    @NSManaged public var slideNumber: Int32
    @NSManaged public var slidePreview: URL
    @NSManaged public var slideTime: Int32
    @NSManaged public var wpm: NSSet

}

// MARK: Generated accessors for wpm
extension Slide {

    @objc(addWpmObject:)
    @NSManaged public func addToWpm(_ value: WPM)

    @objc(removeWpmObject:)
    @NSManaged public func removeFromWpm(_ value: WPM)

    @objc(addWpm:)
    @NSManaged public func addToWpm(_ values: NSSet)

    @objc(removeWpm:)
    @NSManaged public func removeFromWpm(_ values: NSSet)

}
