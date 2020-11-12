//
//  HomeViewController.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 27/10/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa

let getFileName =
"""
    tell application "Finder"
        open POSIX file "%@"
    end tell
"""

class HomeViewController: NSViewController {

    @IBOutlet weak var helloText: NSTextField!
    @IBOutlet weak var keynoteTextField: NSTextField!
    @IBOutlet weak var maxDurationTextField: NSTextField!
    @IBOutlet weak var historyPlaceHolderText: NSTextField!
    
    var keynotFilePath = ""
    var duraationsInSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        timerStepper.integerValue = 0
        maxDurationTextField.stringValue = String(timerStepper.integerValue)
        let testImage = URL(fileURLWithPath: "/Users/calvindalenta/Documents/Foto KTP.jpg")
                       let testWPM: cWPM = cWPM(position: 2, wordsPerMinute: 2, audioPath: URL(fileURLWithPath: "audxxoo"), slideNumber: 1)
                       let testSlide: cSlide = cSlide(number: 2, time: 2, preview: testImage)
                       let testPractice: cPractice = cPractice(ID: UUID(), keynoteName: URL(fileURLWithPath: "Keynote test5"), keynotePreview: testImage, maxDuration: 13, totalTime: 99, slides: [testSlide], WPMs: [testWPM])

               //        CoreDataManager.shared.deleteAllPractices()
                       if (CoreDataManager.save(practice: testPractice)){
                           let practices = CoreDataManager.fetchPractices()
                           for practice in practices{
               //                if (practice.keynoteName == "Keynote test3"){
               //                    CoreDataManager.shared.delete(practice: practice)
               //                    continue
               //                }
                               print(practice.keynoteName)
                               print(practice.slides)
                               print(practice.WPMs)
                               print(practice.maxDuration)
                           }
                       }
    }
    
    
    @IBAction func onChooseFile(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = ["key"]
        openPanel.begin { (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                //Do what you will
                //If there's only one URL, surely 'openPanel.URL'
                //but otherwise a for loop works
                if let resultString = openPanel.url?.path {
                    self.keynoteTextField.stringValue = resultString
                    self.keynotFilePath = String(format: getFileName, resultString)
                }
                
            }
        }
    }
    
    @IBAction func onStartPractice(_ sender: NSButton) {
        let script = NSAppleScript(source: keynotFilePath)
        var error = NSDictionary?.none
        script?.executeAndReturnError(&error)
        print(error)
    }
    
    
    
    @IBOutlet weak var timerStepper: NSStepper!
    @IBAction func onStepperChange(_ sender: NSStepper) {
        sender.increment = 1
        maxDurationTextField.stringValue = String(timerStepper.integerValue)
        duraationsInSeconds = timerStepper.integerValue*60
    }

}
