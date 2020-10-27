//
//  HomeViewController.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 27/10/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa

class HomeViewController: NSViewController {

    @IBOutlet weak var helloText: NSTextField!
    @IBOutlet weak var keynoteTextField: NSTextField!
    @IBOutlet weak var maxDurationTextField: NSTextField!
    @IBOutlet weak var historyPlaceHolderText: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func onChooseFile(_ sender: NSButton) {
    }
    
    @IBAction func onStartPractice(_ sender: NSButton) {
    }
    
    @IBAction func onStepperChange(_ sender: NSStepper) {
    }
}
