//
//  viewPastHistory4.swift
//  MacroPresent
//
//  Created by Rais Mohamad Najib on 11/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa
import AVFoundation

class viewPastHistory4: NSCollectionViewItem {

    @IBOutlet weak var buttonImage: NSButton!
    @IBOutlet weak var maxTime4: NSTextField!
    @IBOutlet weak var currentTime4: NSTextField!
    @IBOutlet weak var textAnalisa: NSTextField!
    @IBOutlet weak var audioSliderImage: NSSlider!
    
    var audio: AVAudioPlayer?
    var playingAudio: String?
    var timer: Timer?
    
    //var buttonAudioURL = URL(fileURLWithPath: Bundle.main.path(forResource: playingAudio, ofType: "mp3")!)
    //var buttonAudioURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: self().playingAudio, ofType: "mp3")!)
    var buttonaAudioURL = URL(fileURLWithPath: Bundle.main.path(forResource: "01BloodAndWine", ofType: "mp3")!)
    //var buttonAudioPlayer = AVAudioPlayer(contentsOf: buttonaAudioURL)
    //var buttonAudioPlayer = AVAudioPlayer?
    var buttonAudioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        //buttonAudioPlayer = AVAudioPlayer(contentsOf: buttonaAudioURL)
        //updateTimer()
        //UpdateSlider()
        setAudio()

        
    }
    
    func setAudio() {
        //untuk masukin ke url supaya buat play
        let url = Bundle.main.path(forResource: playingAudio, ofType: "mp3")
        do {
            guard let url = url else{
                return
            }
            audio = try AVAudioPlayer(contentsOf: URL(string: url)!)
            
            guard let audio = audio else {
                return
            }
            audio.prepareToPlay()
            audioSliderImage.maxValue = Double(audio.duration)
            
            let maxTime = Int(audioSliderImage.maxValue)
            
            hmsFrom(seconds: Int(maxTime)) { (minutes, seconds) in
                //let hours = self.getStringFrom(seconds: hours)
                let minutes = self.getStringFrom(seconds: minutes)
                let seconds = self.getStringFrom(seconds: seconds)
                self.maxTime4.stringValue = "\(minutes):\(seconds)"
            }
            
            if audioSliderImage.intValue > 0 {
                audio.currentTime = TimeInterval(audioSliderImage.intValue)
                audio.pause()
            }else {
                audioSliderImage.intValue = 0
            }
            //audio.play()
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.UpdateSlider), userInfo: nil, repeats: true)
            
            //try AVAudioPlayer
        } catch {
            print("something when wrong")
        }
    }
    
    //override func
    
//    func updateTimer(){
//        switch playingAudio {
//        case "01BloodAndWine":
//            currentTime4.stringValue = "2000"
//            maxTime4.stringValue = "4pppp"
//        case "10SilverForMonsters":
//            currentTime4.stringValue = "10000"
//            maxTime4.stringValue = "6pppp"
//        default:
//            currentTime4.stringValue = "xxxxx"
//            maxTime4.stringValue = "XXX"
//        }
//
//
////        currentTime4.stringValue = "2000"
////        maxTime4.stringValue = "4pppp"
//    }
    
    func hmsFrom(seconds: Int, completion: @escaping (_ minutes: Int, _ seconds: Int)->()) {

            completion((seconds % 3600) / 60, (seconds % 3600) % 60)

    }

    func getStringFrom(seconds: Int) -> String {

        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    @objc func UpdateSlider(){
        
        audioSliderImage.intValue = Int32(Int(audio!.currentTime))
        
        let seconds = audioSliderImage.intValue
        
        hmsFrom(seconds: Int(seconds)) { (minutes, seconds) in
            //let hours = self.getStringFrom(seconds: hours)
            let minutes = self.getStringFrom(seconds: minutes)
            let seconds = self.getStringFrom(seconds: seconds)
            self.currentTime4.stringValue = "\(minutes):\(seconds)"
        }
        
        
        
        
        //let date = Date()
        
        //currentTime4.stringValue = "\(audioSliderImage.intValue)"
        
        
        //audioSliderImage.doubleValue = Double(audio!.currentTime)
        //currentTime4.stringValue = String(format: "%.0f", audioSliderImage.doubleValue)
        
        //let formater= DateComponentsFormatter()
        
        
        
        //audioSliderImage.intValue = Int32(Int(audio!.currentTime))
//        audioSliderImage.intValue = Int32(audio!.currentTime)
//        currentTime4.stringValue = String(format: "%.0f", audioSliderImage.intValue)
        //let doubletoFloat64 = Float64(audioSliderImage.double)
        //let doubletoInt = Int(audioSliderImage.doubleValue)
        
        //let seconds = CMTimeGetSeconds(doubletoFloat64)
        //let seconds = CMTimeGetSeconds()
        
//        let formater = DateComponentsFormatter()
//        formater.allowedUnits = [.minute, .second]
//        formater.unitsStyle = .positional
//
//        let formattedString = formater.string(from: TimeInterval(audioSliderImage.doubleValue))
//        currentTime4.stringValue = formattedString!
        
        //currentTime4.stringValue = String(format: "%.0f", audioSliderImage.doubleValue)
        //currentTime4.stringValue = String(format: "%.0f", audioSliderImage.doubleValue)
        //currentTime4.stringValue = "\(Float(audioSliderImage.doubleValue))"
    }
    
    @IBAction func audioSliderAction(_ sender: Any) {
        switch true {
        case audio?.isPlaying:
            audio?.stop()
            audio?.currentTime = TimeInterval(audioSliderImage.intValue)
            audio?.prepareToPlay()
            audio?.play()
        default:
            audio?.pause()
            audio?.currentTime = TimeInterval(audioSliderImage.intValue)
        }
    }
    
    @IBAction func buttonAudio(_ sender: Any) {
        
        // cek fungsi button
        switch true {
        //cek ini apakah audio sedang jalan
        case audio?.isPlaying:
            audio?.pause()
        // cek apakah audi sudah ada isinya apa belum, jadi kalau udah ada berrarti kepause apa kestop, jadi jalanin lagi.
        case audio != nil:
            audio?.play()
        //fungsi kalau yang atas gak jalan smeua
        default:
            //audio?.play()
            setAudio()
            audio?.play()
        //setAudiotoPlay()
            //setAudio()
        }
        
        // old code, sangat tidak efisien, not recomended

//        if let audio = audio, audio.isPlaying {
//            audio.pause()
//        }else if audio != nil {
//            audio?.play()
//        }else{
//            setAudio()
//        }
        
//
        //setAudio()
        //playingAudio
        //this one yang dulu ya
//        let url = Bundle.main.path(forResource: playingAudio, ofType: "mp3")
//        //print(playingAudio)
//
//        //cek jika sedang jalan maka dia akan pause
//        if let audio = audio, audio.isPlaying {
//            //stop playback
//            audio.pause()
//
//          //cek, apakah udah jalan sebelumnya, audio tidak kosong, maka melanjutkan
//        } else if audio != nil{
//            audio?.play()
//            //audio kosong maka jalanin ini
//        } else{
//            //set up player, and play
//            do{
//                guard let url = url else {
//                    return
//                }
//                audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
//
//                guard let audio = audio else {
//                    return
//                }
//                //audio.pl
//                audio.play()
//            }
//            catch {
//                print("something when wrong")
//            }
//        }
    }
}

