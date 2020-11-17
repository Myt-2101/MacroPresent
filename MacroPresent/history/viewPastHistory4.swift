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
    //var playingAudio: String?
    var timer: Timer?
    var urlAudio: URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        

        
    }
    
    func setAudio() {
        do {
            //langsung play
            audio = try AVAudioPlayer(contentsOf: urlAudio!)
            //audio = try AVAudioPlayer(contentsOf: URL(string: url)!)
            
            guard let audio = audio else {
                return
            }
            audio.prepareToPlay()
            audioSliderImage.maxValue = Double(audio.duration)
            
            let maxTime = Int(audioSliderImage.maxValue)
            
            //set waktu int to 00:00:00
            hmsFrom(seconds: Int(maxTime)) { (minutes, seconds) in
                
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
            //set timer supaya slider jalan
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.UpdateSlider), userInfo: nil, repeats: true)
            
            //try AVAudioPlayer
        } catch {
            print("something when wrong")
        }
    }
    
    
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
        default:
            audio?.play()
            
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

