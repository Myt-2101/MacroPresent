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
    var error=NSDictionary?.none
    
    var pathToPictureDir: String!
//VARIABLE
    
//RECORDING AND RECOGNIZING
    var timerRecording: TimerRecording!
//    var colorRecording: ColorRecording!
    
    var homeView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        keynoteName.stringValue = "Slide \(getCurrentslideValue())"
        
        timerRecording = TimerRecording(basePath: "\(FileManager.default.currentDirectoryPath)/Recordings", interval: 15, view: self.view)
        let picturesDir = FileManager.SearchPathDirectory.picturesDirectory
        let domainMask = FileManager.SearchPathDomainMask.userDomainMask
        pathToPictureDir = NSSearchPathForDirectoriesInDomains(picturesDir, domainMask, true)[0]
        
    }
     

    override func viewDidAppear() {
        view.window?.level = .mainMenu
        view.window?.delegate = self
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
        
        timerRecording.startTimer()
//        colorRecording.start()
    }
    

    
    @IBAction func StopButton(_ sender: Any) {
        NextButtonOutlet.isHidden=true
        StopButtonOutlet.isHidden=true
        previousSlideButtonOutlet.isHidden=true
        nextSlideButtonOutlet.isHidden=true
        StopPresentation()
        stopTimer()
        stopTimerPerSlide()
        newSlideTimer()
        
        timerRecording.stopTimer()
//        colorRecording.stop()
        
        //TODO: Show the user that we want to wait for 5 seconds
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if (self.saveToDatabase()){
                //TODO: Back to home after saving data
                self.view.window?.performClose(self)
            }
 
        }
    }
    
    
    func saveToDatabase() -> Bool{
        var wpms: [cWPM] = []
        var slides: [cSlide] = []

        wpms = self.timerRecording.WPMs
//        for wpm in self.timerRecording.WPMs{
//            wpms.append(wpm)
//        }

        let keynotePath = UserDefaults.standard.url(forKey: "keynoteFilePath")!
        let keynoteName = keynotePath.deletingPathExtension().lastPathComponent
        let maxDuration = UserDefaults.standard.integer(forKey: "maxDuration")
        
//        let keynotePath = URL(fileURLWithPath:"/Users/calvindalenta/Downloads/Persona Draft.key")
//        let keynoteName = keynotePath.deletingPathExtension().lastPathComponent
//        let maxDuration = 10
        
        let format = "%03d"
        let folderName = "\(keynoteName) Present It"
        if self.arrayTimePerSlide.count != 0 {
            for index in 0..<self.arrayTimePerSlide.count{
                //TODO: Get slide preview URL
                let formattedNumber = String(format: format, index+1)
                let newSlide = cSlide(number: index+1,
                                      time: self.arrayTimePerSlide[index],
                                      preview: URL(fileURLWithPath: "\(self.pathToPictureDir!)/\(folderName)/\(folderName).\(formattedNumber).jpeg"))
                
                slides.append(newSlide)
            }
        }
        
        //TODO: keynoteName, keynotePreview, maxDuration
        let practice = cPractice(ID: UUID(),
                                 keynoteName: keynotePath,
                                 keynotePreview: URL(fileURLWithPath: "\(self.pathToPictureDir!)/\(folderName)/\(folderName).001.jpeg"),
                                 maxDuration: maxDuration,
                                 totalTime: self.timeInSeconds,
                                 slides: slides,
                                 WPMs: wpms)
        
        for slide in practice.slides{
            print(slide.preview)
        }
        
        return true
//        return CoreDataManager.save(practice: practice)
    }
   
   
    @IBAction func NextSlide(_ sender: Any) {
        GotoNextSlide()
        let currentSlideValue = getCurrentslideValue()
        print(currentSlideValue)
        
        timerRecording.currentSlideNumber = currentSlideValue
        
        if(currentSlideValue != getMaxslideValue()) {
            newSlideTimer()
            print(arrayTimePerSlide)
            print(averageTimePerSlide)
            keynoteName.stringValue = "Slide \(currentSlideValue)"
        }
        //startTimePerSlide()
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

extension KeynoteTimer: NSWindowDelegate{
//    func windowShouldClose(_ sender: NSWindow) -> Bool {
//        print("1")
//        self.homeView.window?.setIsVisible(true)
//        return true
//    }

    func windowWillClose(_ notification: Notification) {
        self.homeView.window?.setIsVisible(true)
    }
}





