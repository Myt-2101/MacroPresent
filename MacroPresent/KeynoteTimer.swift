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
tell application "Keynote"
    activate
set ThisDocument to make new document
start ThisDocument from the first slide of ThisDocument in window
"""

let stopPresent = """
set ThisDocument to the name of the front document
stop ThisDocument
"""

//Variable

class KeynoteTimer: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    //IBOutlet
    @IBOutlet weak var PreviousSlideOutlet: NSButton!
    @IBOutlet weak var NextSlideOutlet: NSButton!
    @IBOutlet weak var PlayButtonOutlet: NSButton!
    @IBOutlet weak var keynoteName: NSTextField!
    @IBOutlet weak var totalTime: NSTextField!
    @IBOutlet weak var timePerSlide: NSTextField!
    @IBOutlet weak var NextButtonOutlet: NSButton!
    //IBOutlet
    
    //IBAction
    @IBAction func nextButton(_ sender: Any) {
        NextButtonOutlet.isHidden=false
        PlayButtonOutlet.isHidden=true
        PreviousSlideOutlet.isHidden=false
        NextSlideOutlet.isHidden=false
        
        //StartPresentation()
    }
    
    @IBAction func StopButton(_ sender: Any) {
        NextButtonOutlet.isHidden=true
        PlayButtonOutlet.isHidden=false
        PreviousSlideOutlet.isHidden=true
        NextSlideOutlet.isHidden=true
        
        //StopPresentation()
    }
    //IBAction
    
    //Functions
    @objc func StartPresentation() {
        let Start = NSAppleScript(source: StartPresent)
        var error=NSDictionary?.none
        Start?.executeAndReturnError(&error)
        print(error ?? TID_NULL)
    }
    
    @objc func StopPresentation() {
        let stop = NSAppleScript(source: stopPresent)
        var error=NSDictionary?.none
        stop?.executeAndReturnError(&error)
        print(error ?? TID_NULL)
    }
    
    //Functions
}





