//
//  KeynoteTimer.swift
//  MacroPresent
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 27/10/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa
import Foundation
import Speech

//AppleScript Variable
let StartPresent = """
tell application "Keynote"
start the front document from the first slide of the front document
end tell
"""

let stopPresent = """
tell application "Keynote"
quit 
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
class View: NSView {
    override var acceptsFirstResponder: Bool{return true}
    
}


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
    var slideindex=1
    var pathToPictureDir: String!
//VARIABLE

   
//RECORDING AND RECOGNIZING
    var timerRecording: TimerRecording!
//    var colorRecording: ColorRecording!
    
    var homeView: NSView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        keynoteName.stringValue = "Slide \(getCurrentslideValue())"
        let musicDir = FileManager.SearchPathDirectory.musicDirectory
        let picturesDir = FileManager.SearchPathDirectory.picturesDirectory
        let domainMask = FileManager.SearchPathDomainMask.userDomainMask
        
        timerRecording = TimerRecording(basePath: "\(NSSearchPathForDirectoriesInDomains(musicDir, domainMask, true)[0])/Present It Recordings", interval: 10, view: self.view)
        
        pathToPictureDir = NSSearchPathForDirectoriesInDomains(picturesDir, domainMask, true)[0]
        
        
         
        
    }
     
 
  
    override func viewDidAppear() {
        view.window?.level = .mainMenu
        view.window?.delegate = self
        view.window?.makeFirstResponder(self)
        exportImages()
        permissions()
    }

    //IBOutlet
    @IBOutlet weak var previousSlideButtonOutlet: NSButton!
    @IBOutlet weak var StopButtonOutlet: NSButton!
    @IBOutlet weak var totalTime: NSTextField!
    @IBOutlet weak var timePerSlide: NSTextField!
    @IBOutlet weak var NextButtonOutlet: NSButton!
    @IBOutlet weak var keynoteName: NSTextField!
    @IBOutlet weak var nextSlideButtonOutlet: NSButton!
    
    @IBOutlet weak var analyzingText: NSTextField!
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
        timerRecording.startTimer()
        keynoteName.stringValue = "Slide \(slideindex)"
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
        analyzingText.isHidden = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if (self.saveToDatabase()){
                //TODO: Back to home after saving data
                self.analyzingText.isHidden = true
                self.view.window?.performClose(self)
            }
        }
    }
    
    
    func saveToDatabase() -> Bool{
        var slides: [cSlide] = []

//        wpms = self.timerRecording.WPMs
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
                let slideNumber = index + 1
                var newWPMs: [cWPM] = []

                for wpm in timerRecording.WPMs{
                    if (wpm.slideNumber == slideNumber){
                        newWPMs.append(wpm)
                    }
                }
                
                let formattedNumber = String(format: format, slideNumber)
                let newSlide = cSlide(number: slideNumber,
                                      time: self.arrayTimePerSlide[index],
                                      preview: URL(fileURLWithPath: "\(self.pathToPictureDir!)/\(folderName)/\(folderName).\(formattedNumber).jpeg"),
                                      WPMs: newWPMs)
                
                slides.append(newSlide)
            }
        }
        
        let practice = cPractice(ID: UUID(),
                                 keynoteName: keynotePath,
                                 keynotePreview: URL(fileURLWithPath: "\(self.pathToPictureDir!)/\(folderName)/\(folderName).001.jpeg"),
                                 maxDuration: maxDuration,
                                 totalTime: self.timeInSeconds,
                                 slides: slides)
        
        for slide in practice.slides{
            print(slide.preview)
        }
        
        //return true
        return CoreDataManager.save(practice: practice)
    }
   
   
    @IBAction func NextSlide(_ sender: Any) {
        GotoNextSlide()
        slideindex+=1
        let currentSlideValue = getCurrentslideValue()
        print(currentSlideValue)
        keynoteName.stringValue = "Slide \(slideindex)"
        timerRecording.currentSlideNumber = currentSlideValue
        newSlideTimer()
        if(currentSlideValue != getMaxslideValue()) {
            
            print(arrayTimePerSlide)
            print(averageTimePerSlide)
            
        }
        //startTimePerSlide()
    }
    
    override func keyDown(with event: NSEvent) {
        if event.keyCode == 124 {
            GotoNextSlide()
            slideindex+=1
                let currentSlideValue = getCurrentslideValue()
                print(currentSlideValue)
                keynoteName.stringValue = "Slide \(slideindex)"
                timerRecording.currentSlideNumber = currentSlideValue
                newSlideTimer()
        }
        
        if event.keyCode == 123 {
            GotoNextSlide()
            slideindex-=1
                let Previous = NSAppleScript(source: PreviousSlideScript)
                var error = NSDictionary?.none
                Previous?.executeAndReturnError(&error)
                print(error ?? TID_NULL)
                keynoteName.stringValue = "Slide \(slideindex)"
           
        }
        
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
        timerRecording.stopTimer()
        NotificationCenter.default.post(name: .didCloseKeynoteTimer, object: nil)
//        self.homeView?.window?.setIsVisible(true)
    }
}

extension KeynoteTimer{
    func permissions(){
        AVCaptureDevice.requestAccess(for: .audio) { (authStatus) in
            //TODO: Handle authorization
        }
        SFSpeechRecognizer.requestAuthorization { authStatus in
            //TODO: Handle authorization
//            OperationQueue.main.addOperation {
//                switch authStatus{
//                case .authorized:
//                    // Good to go
//                    break
//                case .denied:
//                    // User said no
//                    break
//                case .restricted:
//                    // Device isn't permitted
//                    break
//                case .notDetermined:
//                    // Don't know yet
//                    break
//                default:
//                    break
//                }
//            }
        }
    }
  
}




