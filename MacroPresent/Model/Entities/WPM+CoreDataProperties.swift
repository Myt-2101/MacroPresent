//
//  WPM+CoreDataProperties.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 17/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//
//

import Foundation
import CoreData


extension WPM {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<WPM> {
        return NSFetchRequest<WPM>(entityName: "WPM")
    }

    @NSManaged public var audioPath: URL
    @NSManaged public var position: Int32
    @NSManaged public var slideNumber: Int32
    @NSManaged public var wordsPerMinute: Int32

}
