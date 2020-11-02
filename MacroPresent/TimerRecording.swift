//
//  TimerRecording.swift
//  testrecord2
//
//  Created by Calvin Dalenta on 31/10/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import Foundation
import Speech

class TimerRecording{
    
    var interval: TimeInterval!
    var recordings: [Recording]!
    var folderID: UUID!
    var recordCount: Int!
    var timer: Timer!
    
    var uniqueFolderPath: String!
    
    var currentRecording: Recording!
    
    var speakingRates : [Double]!
    
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
        
        self.speakingRates = []
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
        recognizeCurrent()
    }
    
    private func recognizeCurrent(){
        if (currentRecording != nil){
            if (currentRecording.isRecording){
                currentRecording.stopRecord()
            }
            let record = PreRecordedRecognizer(for: currentRecording.path)
            record.delegate = self
            record.recognize()
        }
    }
    
    @objc func onRecordTimer(){
        stopAllRecordings()
        
        recognizeCurrent()
        
        recordCount += 1

        let newUrl = URL(fileURLWithPath: "\(self.uniqueFolderPath!)/\(recordCount!).m4a")
        let newRecord = Recording(path: newUrl)
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
    func didUpdateTranscript(result: SFSpeechRecognitionResult) {
        speakingRates.append(result.bestTranscription.speakingRate)
    }
}

