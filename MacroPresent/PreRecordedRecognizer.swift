//
//  TestRecognizer.swift
//  testrecog
//
//  Created by Calvin Dalenta on 22/10/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import Cocoa
import Foundation
import Speech

protocol RecognizerTaskDelegate{
    func didUpdateTranscript(result: SFSpeechRecognitionResult)
}

class PreRecordedRecognizer{
    
    var speechRecognizer: SFSpeechRecognizer!
    var path: URL!
    
    var delegate : RecognizerTaskDelegate?
    
    /// Recognizing a pre-recorded audio file
    /// ```
    /// var path = "Users/calvindalenta/Documents/Recordings/foo.m4a"
    /// var preRecordedRecognizer = PreRecordedRecognizer(for: path)
    /// ```
    /// - Parameter for: Full path to an existing audio file
    init(for path: URL){
        self.path = path
        speechRecognizer = SFSpeechRecognizer()
    }
    
    public func recognize(){
        
        askPermission()
        
        if !speechRecognizer.isAvailable {
            fatalError("Speech recognizer is not available")
        }
        let request = SFSpeechURLRecognitionRequest(url: path)
//        request.shouldReportPartialResults = true

        // will now ask for authorisation
        speechRecognizer.recognitionTask(with: request) { (_result, _error) in
            if (_error != nil){
                print("ERROR: \(String(describing: _error))")
                return
            }
            guard let result = _result else {
                return
            }
            self.handleResult(result: result)
        }
    }
    
    private func handleResult(result:  SFSpeechRecognitionResult){
        //TODO: Hasil resultnya mau diapain dan disimpen kemana
        
        if (result.isFinal){
//            print("File saved at: \(path!)")
//            print("Text: \(result.bestTranscription.formattedString) ")
//            print("Average pause: \(result.bestTranscription.averagePauseDuration)")
            print("Speaking rate: \(result.bestTranscription.speakingRate)")
            delegate?.didUpdateTranscript(result: result)
            
//            print(AVAsset(url: path).duration)
        }
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
