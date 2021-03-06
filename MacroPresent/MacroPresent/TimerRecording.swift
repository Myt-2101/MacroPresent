//
//  TimerRecording.swift
//  testrecord2
//
//  Created by Calvin Dalenta on 31/10/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import Foundation
import Speech
import Cocoa

class TimerRecording{
    
    var folderID: UUID!
    var recordCount: Int!
    var interval: TimeInterval!
    var timer: Timer!
    var uniqueFolderPath: String!
    var currentRecording: Recording!
    var recordings: [Recording]!
    var WPMs : [cWPM]!
    
    var currentSlideNumber: Int!
    
    var view: NSView!
    
    /// This function will create a new unique folder to save all the audio files,
    /// ```
    /// var path = "Users/calvindalenta/Documents/"
    /// var recording = TimerRecording(basePath: path, interval: 30)
    /// "Users/calvindalenta/Documents/[folderID]/[recordCount].m4a"
    /// ```
    /// - Parameter basePath: Folder path to save audio files
    /// - Parameter interval: The duration for every recording
    init(basePath: String, interval: TimeInterval, view: NSView){
        self.interval = interval
        self.recordings = []
        self.folderID = UUID()
        self.recordCount = 0
        self.WPMs = []
        self.uniqueFolderPath = createPath(path: basePath)
        
        self.currentSlideNumber = 1
        
        self.view = view
        self.view.wantsLayer = true
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(onRecordTimer), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func stopTimer(){
        if timer != nil {
            timer.invalidate()
        }
        stopAllRecordings()
        
        //Recognize rekaman terakhir yang kepotong button stop
        recognizeCurrent()

//        //Analisis semua rekamannya | error
//        if (currentRecording != nil){
//            recordings.append(currentRecording)
//        }
//        for recording in recordings{
//            let recognizer = PreRecordedRecognizer(for: recording)
//            recognizer.delegate = self
//            recognizer.recognize()
//        }
    }

    func stopAllRecordings(){
        if (recordings != nil) {
            for record in recordings! {
                if record.isRecording{
                    record.stopRecord()
                }
            }
        }
    }
    
    @objc func onRecordTimer(){
        stopAllRecordings()
        
        recognizeCurrent()
        
        recordCount += 1

        let newUrl = URL(fileURLWithPath: "\(uniqueFolderPath!)/\(recordCount!).m4a")
        let newRecord = Recording(path: newUrl, position: recordCount!, slideNumber: getSlideNumber())
        newRecord.startRecord()
        recordings.append(newRecord)
        currentRecording = newRecord
        
        print("\(newRecord.url.path)")
    }
    
    private func recognizeCurrent(){
        if (currentRecording != nil){
            if (currentRecording.isRecording){
                currentRecording.stopRecord()
            }
            let record = PreRecordedRecognizer(for: currentRecording)
            record.delegate = self
            record.recognize()
        }
        currentRecording = nil
    }
    
    private func createPath(path: String) -> String{
        let newPath = "\(path)/\(folderID!)/"
        return newPath
    }
    
    private func getSlideNumber() -> Int{
        //TODO: Slide numbernya dapet darimana
        return currentSlideNumber
    }
//
//    var recognizeCount = 0
//    func recognize(){
//        let record = PreRecordedRecognizer(for: recordings[recognizeCount])
//        record.delegate = self
//        record.recognize()
//    }
}

extension TimerRecording : RecognizerTaskDelegate{
    func didFinishRecognizing(_ result: cWPM) {
        WPMs.append(result)
        
        let wpm = result.wordsPerMinute
        
        if wpm < 140 {
            view.layer?.backgroundColor = TimerColor.blue
        } else if wpm > 170 {
            view.layer?.backgroundColor = TimerColor.red
        } else {
            view.layer?.backgroundColor = TimerColor.green
        }
        
//        recognizeCount += 1
//        if(recognizeCount < recordings.count){
//            recognize()
//        }
    }
}
