//
//  Slide+CoreDataProperties.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 10/11/20.
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

}
