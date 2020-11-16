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
        updateTimer()
        

        
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
            audio.play()
            //try AVAudioPlayer
        } catch {
            print("something when wrong")
        }
    }
    
    //override func
    
    func updateTimer(){
        switch playingAudio {
        case "01BloodAndWine":
            currentTime4.stringValue = "2000"
            maxTime4.stringValue = "4pppp"
        case "10SilverForMonsters":
            currentTime4.stringValue = "10000"
            maxTime4.stringValue = "6pppp"
        default:
            currentTime4.stringValue = "xxxxx"
            maxTime4.stringValue = "XXX"
        }
        
        
//        currentTime4.stringValue = "2000"
//        maxTime4.stringValue = "4pppp"
    }
    
    func UpdateSlider(){
        
    }
    
    @IBAction func audioSliderAction(_ sender: Any) {
        audio?.play()
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
            setAudio()
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

