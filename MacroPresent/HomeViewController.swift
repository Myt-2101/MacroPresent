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
    @IBOutlet weak var listPastHistory2: NSCollectionView!
    @IBOutlet weak var listPastHistory3: NSCollectionView!
    
    var collectionviewhidden2:Int =  0
    var collectionviewhideen3:Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        historyPlaceHolderText.isHidden = true
        //listPastHistory2.isHidden = true
        
        let nibPastHistory1 = NSNib(nibNamed: "viewPastHistory1", bundle: nil)
        listPastHistory1.register(nibPastHistory1, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory1"))
        
        let nibPastHistory2 = NSNib(nibNamed: "viewPastHistory2", bundle: nil)
        listPastHistory2.register(nibPastHistory2, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory2"))
        
        let nibPastHistory3 = NSNib(nibNamed: "viewPastHistory3", bundle: nil)
        listPastHistory3.register(nibPastHistory3, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory3"))
        
        //self.listPastHistory1.register(nibPastHistory1, forItemWithIdentifier: "")
        //listPastHistory1.register(nibPastHistory1, forItemWithIdentifier: "viewPastHisdeltory1")
        
        listPastHistory1.delegate = self
        listPastHistory1.dataSource = self
        listPastHistory2.delegate = self
        listPastHistory2.dataSource = self
        listPastHistory3.delegate = self
        listPastHistory3.dataSource = self
        
        setName()
        setPastHistory1()
        setHiddenCollectionView()
    }
    
    func setPastHistory1(){
        listPastHistory1.backgroundColors = [NSColor.clear]
        listPastHistory2.backgroundColors = [NSColor.clear]
        listPastHistory3.backgroundColors = [NSColor.clear]
    }
    
    func setHiddenCollectionView(){
        if (collectionviewhidden2 == 1){
            listPastHistory2.isHidden = true
            listPastHistory3.isHidden = true
        }else if (collectionviewhidden2 == 0 && collectionviewhideen3 == 1) {
            listPastHistory2.isHidden = false
            listPastHistory3.isHidden = true
        }else if (collectionviewhidden2 == 0 && collectionviewhideen3 == 0){
            listPastHistory2.isHidden = false
            listPastHistory3.isHidden = true
        }

    }
    
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == listPastHistory2){
            return 3
        }else if (collectionView == listPastHistory3){
            return 2
        }
        return 5
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        //let item = collectionview.ma
        //let item = collectiinview.ma
        //let cell = listPastHistory1.deque
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory1"), for: indexPath) as! viewPastHistory1
        if (collectionView == listPastHistory2){
            let item2 = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory2"), for: indexPath) as! viewPastHistory2
            return item2
        }else if (collectionView == listPastHistory3){
            let item3 = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory3"), for: indexPath) as! viewPastHistory3
            return item3
        }
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
