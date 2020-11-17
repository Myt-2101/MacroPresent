//
//  Structs.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 04/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Foundation
import Cocoa

//c for client

public struct cWPM{
    var position: Int
    var wordsPerMinute: Int
    var audioPath: URL
    var slideNumber: Int
}

public struct cSlide{
    var number: Int
    var time: Int
    var preview: URL
    var WPMs: [cWPM]
}

public struct cPractice{
    var ID: UUID
    var keynoteName: URL
    var keynotePreview: URL
    var maxDuration: Int
    var totalTime: Int
    var slides: [cSlide]
    //var WPMs: [cWPM]
}

public struct Keynote{
    var keynoteName: URL
    var keynotePreview: URL
    var practices: [cPractice]
}
