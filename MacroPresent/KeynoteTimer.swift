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
start the front document from the first slide of the front document
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

let Getcurrentslidevalue = """
tell application "Keynote"
    tell the front document
        set slidenum to slide number of the current slide
    end tell
end tell
"""

let ExportImages = """
set Defaultdest to (path to pictures folder)
tell application "Keynote"
    try
        set ThisDocument to the front document
        set documentName to the name of the front document
        if documentName ends with ".key" then
            set documentName to text 1 thru -5 of documentName
        end if
        
        tell application "Finder"
            set newFolder to documentName & " Present It"
            set the targetFolder to make new folder at Defaultdest with properties {name:newFolder}
            set the targetFolderExport to targetFolder as string
        end tell
    
        export front document as slide images to file targetFolderExport with properties {image format:JPEG, skipped slides:true, compression factor:0.8}

        on error ErrorMessage number ErrorNumber
        error number -128
    end try

end tell
"""

//let next2 = NSAppleScript(source: NextSlideScript)

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
    var error=NSDictionary?.none
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
        startTimePerSlide()
        exportImages()
    }
    

    
    @IBAction func StopButton(_ sender: Any) {
        NextButtonOutlet.isHidden=false
        StopButtonOutlet.isHidden=true
        previousSlideButtonOutlet.isHidden=true
        nextSlideButtonOutlet.isHidden=true
        StopPresentation()
        
        
    }
    
    
   
   
    @IBAction func NextSlide(_ sender: Any) {
        GotoNextSlide()
        print(getCurrentslideValue())
        if(getCurrentslideValue() != getMaxslideValue()) {
            newSlideTimer()
            print(arrayTimePerSlide)
            print(averageTimePerSlide)
            keynoteName.stringValue = "Slide \(getCurrentslideValue())"
        }
        startTimePerSlide()
           
           
            
    }
    
    
    
    @IBAction func previousSlideButton(_ sender: Any) {
        let Previous = NSAppleScript(source: PreviousSlideScript)
            var error = NSDictionary?.none
            Previous?.executeAndReturnError(&error)
            print(error ?? TID_NULL)
        
        if(getCurrentslideValue() >= 1){
            keynoteName.stringValue = "Slide \(getCurrentslideValue())"}
        
    
    }
    
    
    
    
    //IBAction
    
    //Functions
    
//    PLAY SLIDE PRESENTASI
    @objc func StartPresentation() {
        let Start = NSAppleScript(source: StartPresent)
        Start?.executeAndReturnError(&error)
        print(error ?? TID_NULL)
    }
//    STOP PLAY PRESENTASI
    @objc func StopPresentation() {
        let stop = NSAppleScript(source: stopPresent)
        stop?.executeAndReturnError(&error)
        print(error ?? TID_NULL)
        stopTimer()
        stopTimerPerSlide()
    }
    
//    SETIAP SLIDE GANTI RESET TIMER
    func newSlideTimer(){
        arrayTimePerSlide.append(timerInSeconds)
        timerInSeconds = 0

    }
//    UNTUK TOTAL TIMER
    func startTotalTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startInSeconds), userInfo: nil, repeats: true)
    }
//    UNTUK MENGHITUNG DURASI TOTAL TIMER DALAM DETIK
    @objc func startInSeconds(){
        timeInSeconds += 1
        interval1 = TimeInterval(timeInSeconds)
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        totalTime.stringValue = formatter.string(from: interval1) ?? ""
    }
//  UNTUK START TIMER PER SLIDE
    func startTimePerSlide(){
        timerPerSlide = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startPerSlide), userInfo: nil, repeats: true)
    }
//   UNTUK MENGHITUNG DURASI TOTAL TIMER PER SLIDE
    @objc func startPerSlide(){
        timerInSeconds += 1
        interval = TimeInterval(timerInSeconds)
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        timePerSlide.stringValue = formatter.string(from: interval) ?? ""
    }
    
//  UNTUK STOP TOTAL TIMER
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    func stopTimerPerSlide(){
        timerPerSlide?.invalidate()
        timerPerSlide = nil
    }
    
    
//    PINDAH KE SLIDE SELANJUTNYA
         func GotoNextSlide(){
            let next = NSAppleScript(source: NextSlideScript)
            next?.executeAndReturnError(&error)
            print(error ?? TID_NULL)
        }
        
    func getMaxslideValue() -> Int{
        let source = """
            tell applications "Keynote"
                set ThisSlide to count of slides of the front document
            end tell
"""
        let script = NSAppleScript(source: source )
      
        return Int(script?.executeAndReturnError(&error).stringValue ?? "") ?? 0

        
    }
    
    func getCurrentslideValue() -> Int{
        let script = NSAppleScript(source: Getcurrentslidevalue)
        
        return Int(script?.executeAndReturnError(&error).stringValue ?? "") ?? 0
    }
    
    func exportImages(){
        let script = NSAppleScript(source: ExportImages)
        script?.executeAndReturnError(&error)
        print(error ?? TID_NULL)
    }
    //Functions
}





