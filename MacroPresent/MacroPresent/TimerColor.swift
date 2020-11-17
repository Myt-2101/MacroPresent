//
//  TimerColor.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 10/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Foundation

/*
 Add "view.wantsLayer = true" in viewDidAppear
 and change the color appropriately using view.layer?.backgroundColor
 "view.layer?.backgroundColor = TimerColor.green"
*/
struct TimerColor{
    static let green = CGColor(red: 0x11/0xFF, green: 0x58/0xFF, blue: 0, alpha: 1) //#115B00
    static let red = CGColor(red: 0x79/0xFF, green: 0, blue: 0, alpha: 1) //#790000
    static let blue = CGColor(red: 0, green: 0x2C/0xFF, blue: 0x79/0xFF, alpha: 1) //#002C79
}
