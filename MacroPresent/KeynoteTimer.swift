//
//  KeynoteTimer.swift
//  MacroPresent
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 27/10/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa

class KeynoteTimer: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    var timer : Timer?
    var timerPerSlide : Timer?
    var timeInSeconds = 0
    var timerInSeconds = 0
    var averageTimePerSlide : Int = 0
    var arrayTimePerSlide = [Int]()
    var formatter = DateComponentsFormatter()
    var interval : TimeInterval = 0
    
    @IBOutlet weak var keynoteName: NSTextField!
    
    @IBOutlet weak var totalTime: NSTextField!
    
    @IBOutlet weak var timePerSlide: NSTextField!
    
    @IBAction func nextButton(_ sender: Any) {
        startTotalTimer()
        startTimePerSlide()
        print(timeInSeconds)
    }
    
    
    @IBOutlet weak var nextSlideButtonOutlet: NSButton!
    @IBAction func nextSlideButton(_ sender: Any) {
        newSlideTimer()
        print(arrayTimePerSlide)
        print(averageTimePerSlide)
    }
    
    
    @IBOutlet weak var previousSlideButtonOutlet: NSButton!
    @IBAction func previousSlideButton(_ sender: Any) {
    }
    
    
    func startTotalTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startInSeconds), userInfo: nil, repeats: true)
        nextSlideButtonOutlet.isHidden = false
        previousSlideButtonOutlet.isHidden = false
    }
    
    @objc func startInSeconds(){
        timeInSeconds += 1
    }
    
    func startTimePerSlide(){
        timerPerSlide = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startPerSlide), userInfo: nil, repeats: true)
    }
    
    @objc func startPerSlide(){
        timerInSeconds += 1
    }
    
    func newSlideTimer(){
        arrayTimePerSlide.append(timerInSeconds)
        timerInSeconds = 0
        
        averageTimePerSlide = timeInSeconds / arrayTimePerSlide.count
        
        interval = TimeInterval(averageTimePerSlide)
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        timePerSlide.stringValue = formatter.string(from: interval) ?? ""
    }
    
}
