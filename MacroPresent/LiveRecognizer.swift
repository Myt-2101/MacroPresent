//
//  LiveRecognizer.swift
//  testrecog
//
//  Created by Calvin Dalenta on 22/10/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import Foundation
import Cocoa
import Speech
import AVFoundation

class LiveRecognizer{
    
    enum Status {
        case Recording
        case Stopped
    }
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale:
    Locale(identifier: "en-US"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    var status: Status!
    
    var delegate : RecognizerTaskDelegate?
    
    init(){
//        speechRecognizer!.delegate = delegate
        status = .Stopped
    }
    
    func startRecording() throws {
        askPermission()
        print("Recording...")
        
        status = .Recording
        // Setup Audio Session
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)

        request.shouldReportPartialResults = true

        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, avAudioTime) in
            self.request.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            // TODO: Handle result
            if (error != nil) {
                print("Error: \(error)")
            }
            guard let result = result else {return}
            self.handleResult(result: result)
        })
    }
    
    private func handleResult(result:  SFSpeechRecognitionResult){
        //TODO: Hasil resultnya mau diapain dan disimpen kemana
        
        print("Live: \(result.bestTranscription.formattedString)")
        print("Speaking Rate: \(result.bestTranscription.speakingRate)")
        //result.bestTranscription.formattedString.split(separator: " ").count
        delegate?.didUpdateTranscript(result: result)
        if result.isFinal{
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }
    
    func stopRecording(){
        print("Stopped")
        status = .Stopped
        audioEngine.stop()
        request.endAudio()
    }
    
    func cancelRecording(){
        print("Cancelled")
        status = .Stopped
        audioEngine.stop()
        recognitionTask?.cancel()
    }
    
    private func askPermission(){
           SFSpeechRecognizer.requestAuthorization { authStatus in
               // Do Auth
               OperationQueue.main.addOperation {
                   switch authStatus{
                   case .authorized:
                       // Good to go
                       break
                   case .denied:
                       // User said no
                       break
                   case .restricted:
                       // Device isn't permitted
                       break
                   case .notDetermined:
                       // Don't know yet
                       break
                   }
               }
           }
       }
    
}
