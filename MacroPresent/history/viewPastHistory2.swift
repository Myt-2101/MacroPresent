//
//  viewPastHistory2.swift
//  MacroPresent
//
//  Created by Rais Mohamad Najib on 09/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa

class viewPastHistory2: NSCollectionViewItem {

    @IBOutlet weak var presentationTitle2: NSTextField!
    //@IBOutlet weak var pptView2: NSButton!
    @IBOutlet weak var notifView2: NSImageView!
    @IBOutlet weak var notifViewNumber2: NSTextField!
    @IBOutlet weak var timePresentation2: NSTextField!
    @IBOutlet weak var pptView2: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    override var isSelected: Bool {
        didSet {
            self.view.layer?.backgroundColor = isSelected ? CGColor(red: 0, green: 0x62/0xFF, blue: 0xCC/0xFF, alpha: 1) : NSColor.clear.cgColor
        }
    }
    
    
    
}
