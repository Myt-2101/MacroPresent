//
//  HomeViewController.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 27/10/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa
//import Uikit

var conth:Int?

class HomeViewController: NSViewController {
    
    @IBOutlet weak var helloText: NSTextField!
    @IBOutlet weak var keynoteTextField: NSTextField!
    @IBOutlet weak var maxDurationTextField: NSTextField!
    @IBOutlet weak var historyPlaceHolderText: NSTextField!
    
    @IBOutlet weak var listPastHistory1: NSCollectionView!
    @IBOutlet weak var listPastHistory2: NSCollectionView!
    @IBOutlet weak var listPastHistory3: NSCollectionView!
    
    var collectionviewhidden2:Int = 0
    var collectionviewhideen3:Int = 0
    var nilai:Int?
    
    //var valueListPstHistory = [dataListHistoryNext]()
    
    var showDataListHistory1 = [dataListHistory1]()
    var showDataListHistory2 = [dataListHistory2]()
    var showDataListHistory3 = [dataListHistory3]()
    
    var indexListPastHistory1: Int?
    var indexListPastHistory2: Int?
    var indexListPastHistory3: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        //hidden tulisan ditengah
        historyPlaceHolderText.isHidden = true
        //listPastHistory2.isHidden = true
        
        
        // add NIb to NSCollection View
        let nibPastHistory1 = NSNib(nibNamed: "viewPastHistory1", bundle: nil)
        listPastHistory1.register(nibPastHistory1, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory1"))
        
        let nibPastHistory2 = NSNib(nibNamed: "viewPastHistory2", bundle: nil)
        listPastHistory2.register(nibPastHistory2, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory2"))
        
        let nibPastHistory3 = NSNib(nibNamed: "viewPastHistory3", bundle: nil)
        listPastHistory3.register(nibPastHistory3, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory3"))
        
        
        /////// CEK YA BRADER
        
        //coba masukin data dummy di nscollection paling kanan
        showDataListHistory3.append(dataListHistory3.init(namePresentationTitle3: "terakhir ketiga 1", namePptView3: "Rectangleppt1", valueTimePresentation3: "10:00:00", nameNotifView3: "rectanglered", nameNotifViewNumber3: 3))
        showDataListHistory3.append(dataListHistory3.init(namePresentationTitle3: "terakhir ketiga 2", namePptView3: "Rectangleppt1", valueTimePresentation3: "20:00:00", nameNotifView3: "rectanglered", nameNotifViewNumber3: 3))
        showDataListHistory3.append(dataListHistory3.init(namePresentationTitle3: "terakhir ketiga 3", namePptView3: "Rectangleppt1", valueTimePresentation3: "30:00:00", nameNotifView3: "rectanglered", nameNotifViewNumber3: 3))
        
        
        
        
        //coba masukin data dummy di ns collection kedua / tengah
        showDataListHistory2.append(dataListHistory2.init(namePresentationTitle2: "kamu yang kedua 1", namePptView2: "Rectangleppt2", valueTimePresentation2: "40:00:00", nameNotifView2: "rectanglered", nameNotifViewNumber2: 2))
        showDataListHistory2.append(dataListHistory2.init(namePresentationTitle2: "kamu yang kedua 2", namePptView2: "Rectangleppt2", valueTimePresentation2: "50:00:00", nameNotifView2: "rectanglered", nameNotifViewNumber2: 2))
        showDataListHistory2.append(dataListHistory2.init(namePresentationTitle2: "kamu yang kedua 3", namePptView2: "Rectangleppt2", valueTimePresentation2: "60:00:00", nameNotifView2: "rectanglered", nameNotifViewNumber2: 2))
        showDataListHistory2.append(dataListHistory2.init(namePresentationTitle2: "kamu yang kedua2 4", namePptView2: "Rectangleppt2", valueTimePresentation2: "70:00:00", nameNotifView2: "rectanglered", nameNotifViewNumber2: 2))
        
        
        
        //masukin data dummy datalist 3 ke datalist 2
        showDataListHistory2[0].setDataListHistory3(setValueDataList3: showDataListHistory3[0], namePresentationTitle2: "kamu yang kedua 1")
        showDataListHistory2[0].setDataListHistory3(setValueDataList3: showDataListHistory3[1], namePresentationTitle2: "kamu yang kedua 1")
        showDataListHistory2[0].setDataListHistory3(setValueDataList3: showDataListHistory3[2], namePresentationTitle2: "kamu yang kedua 1")
        //showDataListHistory2[0].setDataListHistory3(setValueDataList3: showDataListHistory3[3], namePresentationTitle2: "kamu yang kedua 1")
        
        
        //coba masukin data dummy nscollection kiri ke satu
        showDataListHistory1.append(dataListHistory1.init(namePresenttationTitle: "ini 1", namePptView: "Rectangleppt1", nameNotifView: "rectanglered", nameNotifViewNumber: 1))
        showDataListHistory1.append(dataListHistory1.init(namePresenttationTitle: "ini 2", namePptView: "Rectangleppt1", nameNotifView: "rectanglered", nameNotifViewNumber: 1))
        showDataListHistory1.append(dataListHistory1.init(namePresenttationTitle: "ini 3", namePptView: "Rectangleppt1", nameNotifView: "rectanglered", nameNotifViewNumber: 1))
        showDataListHistory1.append(dataListHistory1.init(namePresenttationTitle: "ini 4", namePptView: "Rectangleppt1", nameNotifView: "rectanglered", nameNotifViewNumber: 1))
        showDataListHistory1.append(dataListHistory1.init(namePresenttationTitle: "ini 5", namePptView: "Rectangleppt1", nameNotifView: "rectanglered", nameNotifViewNumber: 1))
        
        
        //masukin data dummy datalist 2 ke datalist 1
        showDataListHistory1[0].setDataListHistory2(setValueDataList2: showDataListHistory2[0], namePresentationTitle: "ini 1")
        showDataListHistory1[0].setDataListHistory2(setValueDataList2: showDataListHistory2[1], namePresentationTitle: "ini 1")
        showDataListHistory1[0].setDataListHistory2(setValueDataList2: showDataListHistory2[2], namePresentationTitle: "ini 1")
        showDataListHistory1[0].setDataListHistory2(setValueDataList2: showDataListHistory2[3], namePresentationTitle: "ini 1")
        
        
        
        //make delegate dan datasource
        listPastHistory1.delegate = self
        listPastHistory1.dataSource = self
        listPastHistory2.delegate = self
        listPastHistory2.dataSource = self
        listPastHistory3.delegate = self
        listPastHistory3.dataSource = self
        
        setName()
        setPastHistory1()
        setHiddenCollectionView()
        print(collectionviewhidden2)
        //print(showDataListHistory1[index])
    }
    
    
    //membuat background di nscollection clear, default deep black
    func setPastHistory1(){
        listPastHistory1.backgroundColors = [NSColor.clear]
        listPastHistory2.backgroundColors = [NSColor.clear]
        listPastHistory3.backgroundColors = [NSColor.clear]
    }
    //logic to hideen collectionview, default collectionview history 2 dan 3 hidden
    func setHiddenCollectionView(){
        if (collectionviewhidden2 == 1){
            listPastHistory2.isHidden = true
            listPastHistory3.isHidden = true
        }else if (collectionviewhidden2 == 0 && collectionviewhideen3 == 1) {
            listPastHistory2.isHidden = false
            listPastHistory3.isHidden = true
        }else if (collectionviewhidden2 == 0 && collectionviewhideen3 == 0){
            listPastHistory2.isHidden = false
            listPastHistory3.isHidden = false
        }

    }
    
    //set nama didepan sesuai dengan nama yang ada pada device eg = Rais Mohamad Najib, Samudra Harnawan , dll
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

extension HomeViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {

    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == listPastHistory2){
            guard let index = indexListPastHistory1 else {return 0}
            return showDataListHistory1[index].getDataListHistory2()
        }else if (collectionView == listPastHistory3){
            guard let index = indexListPastHistory2 else {return 0}
            return showDataListHistory2[index].getDataListHistory3()
        }
        
        return showDataListHistory1.count
}
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory1"), for: indexPath) as! viewPastHistory1

        item.presentationTitle.stringValue = showDataListHistory1[indexPath.item].namePresentationTitle
        item.pptView.image = NSImage(named: showDataListHistory1[indexPath.item].namePptView)
        item.notifView.image = NSImage(named: showDataListHistory1[indexPath.item].nameNotifView)
        item.notifViewNumber.stringValue = "\(showDataListHistory1[indexPath.item].nameNotifViewNumber)"
        
        if (collectionView == listPastHistory2){
            let item2 = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory2"), for: indexPath) as! viewPastHistory2
            

            item2.presentationTitle2.stringValue = showDataListHistory1[indexPath.section].valueDatalistHistory2[indexPath.item].namePresentationTitle2
            item2.pptView2.image = NSImage(named: showDataListHistory1[indexPath.section].valueDatalistHistory2[indexPath.item].namePptView2)
            item2.notifView2.image = NSImage(named: showDataListHistory1[indexPath.section].valueDatalistHistory2[indexPath.item].nameNotifView2)
            item2.notifViewNumber2.stringValue = "\(showDataListHistory1[indexPath.section].valueDatalistHistory2[indexPath.item].nameNotifViewNumber2)"
            item2.timePresentation2.stringValue = showDataListHistory1[indexPath.section].valueDatalistHistory2[indexPath.item].valueTimePresentation2
            return item2
            
        }else if (collectionView == listPastHistory3){
            let item3 = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory3"), for: indexPath) as! viewPastHistory3
            item3.presentationTitle3.stringValue = showDataListHistory2[indexPath.section].valueDatalistHistory3[indexPath.item].namePresentationTitle3
            item3.pptview3.image = NSImage(named: showDataListHistory2[indexPath.section].valueDatalistHistory3[indexPath.item].namePptView3)
            item3.notifView3.image = NSImage(named: showDataListHistory2[indexPath.section].valueDatalistHistory3[indexPath.item].nameNotifView3)
            item3.notifViewNumber3.stringValue = "\(showDataListHistory2[indexPath.section].valueDatalistHistory3[indexPath.item].nameNotifViewNumber3)"
            item3.timePresentation3.stringValue = showDataListHistory2[indexPath.section].valueDatalistHistory3[indexPath.item].valueTimePresentation3
            return item3
        }
        return item
    }
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if (collectionView == listPastHistory1){
            indexListPastHistory1 = indexPaths.first?.item
            listPastHistory2.reloadData()
        }
    }

}






