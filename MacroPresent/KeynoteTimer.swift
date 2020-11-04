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
set ThisDocument to the front document
start ThisDocument from the first slide of ThisDocument
end tell
"""

let stopPresent = """
tell application "Keynote"
set ThisDocument to the front document
stop ThisDocument
end tell
"""

let NextSlideScript = """
tell application "Keynote"
show next
end tell
"""

let PreviousSlideScript = """
tell application "Keynote"
show previous
end tell
"""

//AppleScript Variable



class KeynoteTimer: NSViewController {
//VARIABLE
    var timer : Timer?
    var timerPerSlide : Timer?
    var timeInSeconds = 0
    var timerInSeconds = 0
    var averageTimePerSlide : Int = 0
    var arrayTimePerSlide = [Int]()
    var formatter = DateComponentsFormatter()
    var interval : TimeInterval = 0
    var interval1 : TimeInterval = 0
    var slideindex = 1
//VARIABLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
      
        
    }
    

    override func viewDidAppear() {
       view.window?.level = .mainMenu
    }

  
    

    
    //IBOutlet
    @IBOutlet weak var previousSlideButtonOutlet: NSButton!
    @IBOutlet weak var StopButtonOutlet: NSButton!
    @IBOutlet weak var totalTime: NSTextField!
    @IBOutlet weak var timePerSlide: NSTextField!
    @IBOutlet weak var NextButtonOutlet: NSButton!
    @IBOutlet weak var keynoteName: NSTextField!
    @IBOutlet weak var nextSlideButtonOutlet: NSButton!
    //IBOutlet
    
    //IBAction
    @IBAction func nextButton(_ sender: Any) {

        NextButtonOutlet.isHidden=true
        StopButtonOutlet.isHidden=false
        previousSlideButtonOutlet.isHidden=false
        nextSlideButtonOutlet.isHidden=false
        StartPresentation()
        startTotalTimer()
        keynoteName.stringValue = "Slide \(slideindex)"
    }
    
    @IBAction func StopButton(_ sender: Any) {
        NextButtonOutlet.isHidden=false
        StopButtonOutlet.isHidden=true
        previousSlideButtonOutlet.isHidden=true
        nextSlideButtonOutlet.isHidden=true
        StopPresentation()
        
        
    }
    
    
   
    @IBAction func nextSlideButton(_ sender: Any) {
        GotoNextSlide()
        newSlideTimer()
        print(arrayTimePerSlide)
        print(averageTimePerSlide)
        keynoteName.stringValue = "Slide \(slideindex+1)"
    }
    
    
    
    @IBAction func previousSlideButton(_ sender: Any) {
        if(slideindex != 0){
        keynoteName.stringValue = "Slide \(slideindex-1)"
        }
        
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
    
//    SETIAP SLIDE GANTI RESET TIMER
    func newSlideTimer(){
        arrayTimePerSlide.append(timerInSeconds)
        timerInSeconds = 0
        
        averageTimePerSlide = timeInSeconds / arrayTimePerSlide.count
        
        interval = TimeInterval(averageTimePerSlide)
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        timePerSlide.stringValue = formatter.string(from: interval) ?? ""

    }
//    UNTUK TOTAL TIMER
    func startTotalTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startInSeconds), userInfo: nil, repeats: true)
        nextSlideButtonOutlet.isHidden = false
        previousSlideButtonOutlet.isHidden = false
    }
//    UNTUK MENGHITUNG DURASI TOTAL TIMER DALAM DETIK
    @objc func startInSeconds(){
        timeInSeconds += 1
    }
//  UNTUK START TIMER PER SLIDE
    func startTimePerSlide(){
        timerPerSlide = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startPerSlide), userInfo: nil, repeats: true)
    }
//   UNTUK MENGHITUNG DURASI TOTAL TIMER PER SLIDE
    @objc func startPerSlide(){
        timerInSeconds += 1
    }
    
    @objc func GotoNextSlide(){
        let next = NSAppleScript(source: NextSlideScript)
        var error=NSDictionary?.none
        next?.executeAndReturnError(&error)
        print(error ?? TID_NULL)
    }
    
    //Functions
}





