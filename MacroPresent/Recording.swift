//
//  AudioControl.swift
//  AudioRecorder
//
//  Created by Patrick Günthard on 12.11.18.
//  Copyright © 2018 Patrick Günthard. All rights reserved.
//

import Foundation
import AVFoundation

class Recording : NSObject, AVAudioRecorderDelegate {
    
    var recorder: AVAudioRecorder?
    var url: URL
    var isRecording: Bool
    var slideNumber: Int
    var position: Int
    /// ```
    /// var url = URL(fileURLWithPath: "Users/calvindalenta/Documents/Recordings/foo.m4a")
    /// var recording = Recording(path: url)
    /// ```
    /// - Parameter path: Full path to save the audio file, including the file name and extension
    /// - Parameter position: Recording ke berapa
    /// - Parameter slideNumber: Mulai recording di slide berapa
    init(path: URL, position: Int, slideNumber: Int) {
        
        self.url = path
        self.isRecording = false
        self.slideNumber = slideNumber
        self.position = position
        super.init()
        self.checkPath(path)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            recorder = try AVAudioRecorder(url: self.url, settings: settings)
            recorder?.delegate = self
            recorder?.prepareToRecord()
        } catch {
            print("Creation of AVAudioRecorder failed")
            print(error)
        }
    }
    
    private func checkPath(_ newPath: URL){
        let fileManager = FileManager.default
        var isDir : ObjCBool = false
        
        var thisPath = newPath
        
        if fileManager.fileExists(atPath: thisPath.path, isDirectory: &isDir) {
            if isDir.boolValue {
                // file exists and is a directory
                print("file exists and is a directory")
            } else {
                // file exists and is not a directory
                print("file exists and is not a directory")
            }
        } else {
            // file does not exist
            do{
                if (thisPath.isFileURL){
                    thisPath.deleteLastPathComponent()
                }
                try FileManager().createDirectory(atPath: thisPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
                fatalError("Could not create folder")
            }
        }
    }
    
    
    // recorder.record(forDuration:)
    func startRecord() {
        if(Int((recorder?.currentTime)!) > 0) {
            recorder?.record(atTime: (recorder?.deviceCurrentTime)!)
        }
        else {
            recorder!.record()
        }
        isRecording = true
    }
    
    func pauseRecord() {
        recorder!.pause()
        isRecording = false
    }
    
    func stopRecord() {
        recorder!.stop()
        isRecording = false
    }
    
    func getTime() -> TimeInterval {
        return (recorder?.currentTime)!
    }
    
//    func getValue() -> Float {
//        recorder?.updateMeters()
//        return (recorder?.averagePower(forChannel: 0))!
//    }
}
