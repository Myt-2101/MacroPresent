//
//  viewHistoryCell.swift
//  MacroPresent
//
//  Created by Rais Mohamad Najib on 09/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa

class viewHistoryCell: NSView {

    @IBOutlet weak var presentationView: NSButton!
    @IBOutlet weak var presentationName: NSTextField!
    @IBOutlet weak var presentationNotif: NSImageView!
    @IBOutlet weak var presentationNotifNumber: NSTextField!
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
