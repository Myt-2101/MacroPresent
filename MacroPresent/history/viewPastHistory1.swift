//
//  viewPastHistory1.swift
//  MacroPresent
//
//  Created by Rais Mohamad Najib on 09/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa

class viewPastHistory1: NSCollectionViewItem {

    @IBOutlet weak var presentationTitle: NSTextField!
    @IBOutlet weak var notifView: NSImageView!
    @IBOutlet weak var notifViewNumber: NSTextField!
    @IBOutlet weak var pptView: NSImageView!
    //var viewc = HomeViewController()
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override var isSelected: Bool {
        didSet {
            self.view.layer?.backgroundColor = isSelected ? CGColor(red: 0, green: 0x62/0xFF, blue: 0xCC/0xFF, alpha: 1) : NSColor.clear.cgColor
        }
    }
    
    @IBAction func pptViewButton(_ sender: Any) {
    }
    
}
