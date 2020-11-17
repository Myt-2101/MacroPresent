//
//  viewPastHistory3.swift
//  MacroPresent
//
//  Created by Rais Mohamad Najib on 09/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa

class viewPastHistory3: NSCollectionViewItem {

    @IBOutlet weak var presentationTitle3: NSTextField!
    //@IBOutlet weak var pptview3: NSButton!
    @IBOutlet weak var notifView3: NSImageView!
    @IBOutlet weak var notifViewNumber3: NSTextField!
    @IBOutlet weak var timePresentation3: NSTextField!
    @IBOutlet weak var pptView3: NSImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setItem()
    }
    
    
    func setItem(){
        //presentationTitle.usesSingleLineMode = false
        //presentationTitle2.maximumNumberOfLines = 2
        presentationTitle3.cell?.wraps = true
        presentationTitle3.alignment = .center
        //presentationTitle.lineBreakMode =
        timePresentation3.alignment = .center
    }
    
    override var isSelected: Bool {
        didSet {
            self.view.layer?.backgroundColor = isSelected ? CGColor(red: 0, green: 0x62/0xFF, blue: 0xCC/0xFF, alpha: 1) : NSColor.clear.cgColor
        }
    }
    
}
