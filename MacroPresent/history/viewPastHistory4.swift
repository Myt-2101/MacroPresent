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
    
    var audio: AVAudioPlayer?
    var playingAudio: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func buttonAudio(_ sender: Any) {
        let url = Bundle.main.path(forResource: playingAudio, ofType: "mp3")
        //print(playingAudio)
        
        //cek jika sedang jalan maka dia akan pause
        if let audio = audio, audio.isPlaying {
            //stop playback
            audio.pause()
            
          //cek, apakah udah jalan sebelumnya, audio tidak kosong, maka melanjutkan
        } else if audio != nil{
            audio?.play()
            //audio kosong maka jalanin ini
        } else{
            //set up player, and play
            do{
                guard let url = url else {
                    return
                }
                audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))

                guard let audio = audio else {
                    return
                }
                //audio.pl
                audio.play()
            }
            catch {
                print("something when wrong")
            }
        }
    }
}
