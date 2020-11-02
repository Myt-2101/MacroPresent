//
//  KeynoteTimer.swift
//  MacroPresent
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 27/10/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa
import Foundation

//AppleScript Variable
let StartPresent = """
if application "Keynote" is running then
set ThisDocument to the name of the front document
start ThisDocument from the first slide of ThisDocument in window
"""

//Variable

class KeynoteTimer: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBOutlet weak var keynoteName: NSTextField!
    
    @IBOutlet weak var totalTime: NSTextField!
    
    @IBOutlet weak var timePerSlide: NSTextField!
    
    @IBAction func nextButton(_ sender: Any) {
        StartPresentation()
    }
    
    @objc func StartPresentation() {
        let Start = NSAppleScript(source: StartPresent)
        var error=NSDictionary?.none
        Start?.executeAndReturnError(&error)
        print(error ?? TID_NULL)
    }
    
    
}





