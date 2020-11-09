//
//  HomeViewController.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 27/10/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa
//import Uikit

class HomeViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    @IBOutlet weak var helloText: NSTextField!
    @IBOutlet weak var keynoteTextField: NSTextField!
    @IBOutlet weak var maxDurationTextField: NSTextField!
    @IBOutlet weak var historyPlaceHolderText: NSTextField!
    
    @IBOutlet weak var listPastHistory1: NSCollectionView!
    
    
    //var HostName:
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let nibPastHistory1 = NSNib(nibNamed: "viewPastHistory1", bundle: nil)
        listPastHistory1.register(nibPastHistory1, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory1"))
        //self.listPastHistory1.register(nibPastHistory1, forItemWithIdentifier: "")
        //listPastHistory1.register(nibPastHistory1, forItemWithIdentifier: "viewPastHisdeltory1")
        
        listPastHistory1.delegate = self
        listPastHistory1.dataSource = self
        
        
        setName()
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        //let item = collectionview.ma
        //let item = collectiinview.ma
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory1"), for: indexPath)
        return item
    }
    
    func setName(){
        helloText.stringValue = "Hello, \(NSFullUserName())"
    }
    
    
    @IBAction func onChooseFile(_ sender: NSButton) {
    }
    
    @IBAction func onStartPractice(_ sender: NSButton) {
    }
    
    @IBAction func onStepperChange(_ sender: NSStepper) {
    }
}
