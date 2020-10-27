//
//  KeynoteTimer.swift
//  MacroPresent
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 27/10/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa

class KeynoteTimer: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBOutlet weak var keynoteName: NSTextField!
    
    @IBOutlet weak var totalTime: NSTextField!
    
    @IBOutlet weak var timePerSlide: NSTextField!
    
    @IBAction func nextButton(_ sender: Any) {
    }
    
}
