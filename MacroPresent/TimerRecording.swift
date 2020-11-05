//
//  TimerRecording.swift
//  testrecord2
//
//  Created by Calvin Dalenta on 31/10/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import Foundation
import Speech

public struct cWPM{
    var position: Int
    var wordsPerMinute: Int
    var audioPath: URL
    var slideNumber: Int
}

class TimerRecording{
    
    var interval: TimeInterval!
    var recordings: [Recording]!
    var folderID: UUID!
    var recordCount: Int!
    var timer: Timer!
    
    var uniqueFolderPath: String!
    
    var currentRecording: Recording!
    
    var WPMs : [cWPM]!
    
    /// This function will create a new unique folder to save all the audio files,
    /// ```
    /// var path = "Users/calvindalenta/Documents/"
    /// var recording = TimerRecording(basePath: path, interval: 30)
    /// "Users/calvindalenta/Documents/2151-j193-hfas/1.m4a"
    /// ```
    /// - Parameter basePath: Folder path to save audio files
    /// - Parameter interval: The duration for every recording
    init(basePath: String, interval: TimeInterval){
        self.interval = interval
        self.recordings = []
        self.folderID = UUID()
        self.recordCount = 0
        
        self.WPMs = []
        self.uniqueFolderPath = createPath(path: basePath)
    }
    
    private func createPath(path: String) -> String{
        
        let newPath = "\(path)/\(folderID!)/"

        return newPath
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(onRecordTimer), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func stopTimer(){
        timer.invalidate()
        stopAllRecordings()
        
        //Append rekaman terakhir yang kepotong button stop
        recordings.append(currentRecording)
        recognizeCurrent()

        
//        //Analisis semua rekamannya
//        for recording in recordings{
//            PreRecordedRecognizer(for: recording).recognize()
//        }
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
    
    //TODO: Slide numbernya dapet darimana
    private func getSlideNumber() -> Int{
        return 0
    }
    
    @objc func onRecordTimer(){
        stopAllRecordings()
        
        recognizeCurrent()
        
        recordCount += 1

        let newUrl = URL(fileURLWithPath: "\(self.uniqueFolderPath!)/\(recordCount!).m4a")
        let newRecord = Recording(path: newUrl, position: recordCount!, slideNumber: getSlideNumber())
        newRecord.startRecord()
        recordings?.append(newRecord)
        currentRecording = newRecord
        print("\(newRecord.path.path)")
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
    
}

extension TimerRecording : RecognizerTaskDelegate{
    func didFinishRecognizing(result: cWPM) {
        WPMs.append(result)
    }
}
