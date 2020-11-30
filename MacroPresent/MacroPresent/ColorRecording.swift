//
//  ColorRecording.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 13/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Foundation
import Cocoa

class ColorRecording{
    var timer: Timer!
    var currentRecording: Recording!
    var count = 0
    var currentPath: String!
    
    var view: NSView!
    
    init(view: NSView){
        self.view = view
        
        self.view.wantsLayer = true
        currentPath = "\(FileManager.default.currentDirectoryPath)/Temp"
    }
    
    func start(){
        //Alternative timer: recorder.record(forDuration:)
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func onTimer(){
        count += 1
        if currentRecording != nil {
            currentRecording.stopRecord()
            let recog = PreRecordedRecognizer(for: currentRecording)
            recog.delegate = self
            recog.recognize()
        }
        let url = URL(fileURLWithPath: "\(currentPath!)/foo\(count).m4a")
        currentRecording = Recording(path: url)
        currentRecording.startRecord()
    }
    
    func stop(){
        timer.invalidate()
        if currentRecording != nil {
            currentRecording.stopRecord()
            let recog = PreRecordedRecognizer(for: currentRecording)
            recog.delegate = self
            recog.recognize()
        }
    }
}

extension ColorRecording: RecognizerTaskDelegate{
    func didFinishRecognizing(_ result: cWPM) {
        let wpm = result.wordsPerMinute
        
        print(wpm)
        
        if wpm < 140 {
            view.layer?.backgroundColor = TimerColor.yellow
        } else if wpm > 160 {
            view.layer?.backgroundColor = TimerColor.red
        } else {
            view.layer?.backgroundColor = TimerColor.green
        }
        
        do {
            try FileManager.default.removeItem(at: result.audioPath)
        } catch {
            print(error)
        }
    }
}
