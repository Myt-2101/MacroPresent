//
//  HomeViewController.swift
//  MacroPresent
//
//  Created by Calvin Dalenta on 27/10/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Cocoa
//import Uikit

let getFileName =
"""
    tell application "Finder"
        open POSIX file "%@"
    end tell
"""

class HomeViewController: NSViewController {
    
    @IBOutlet weak var helloText: NSTextField!
    @IBOutlet weak var keynoteTextField: NSTextField!
    @IBOutlet weak var maxDurationTextField: NSTextField!
    @IBOutlet weak var historyPlaceHolderText: NSTextField!
    
    var keynotFilePath = ""
    var duraationsInSeconds = 0
        
    @IBOutlet weak var listPastHistory1: NSCollectionView!
    @IBOutlet weak var listPastHistory2: NSCollectionView!
    @IBOutlet weak var listPastHistory3: NSCollectionView!
    @IBOutlet weak var listPastHistory4: NSCollectionView!
    
    @IBOutlet weak var verticalLine1: NSBox!
    @IBOutlet weak var verticalLine2: NSBox!
    @IBOutlet weak var verticalLine3: NSBox!
    
    var collectionviewhidden2:Int = 0
    var collectionviewhideen3:Int = 0
    var nilai:Int?
    
//    var data: [cPractice] = CoreDataManager.fetchPractices()
    
    var keynotes: [Keynote] = [Keynote]()
    //var valueListPstHistory = [dataListHistoryNext]()
    
    var showDataListHistory1 = [dataListHistory1]()
    var showDataListHistory2 = [dataListHistory2]()
    var showDataListHistory3 = [dataListHistory3]()
    var showDataListHistory4 = [dataListHistory4]()
    
    var indexListPastHistory1: Int?
    var indexListPastHistory2: Int?
    var indexListPastHistory3: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppear()
        // Do view setup here.
        timerStepper.integerValue = 0
        maxDurationTextField.stringValue = String(timerStepper.integerValue)
        
        let keynote = UserDefaults.standard.url(forKey: "keynoteFilePath")
        let maxDuration = UserDefaults.standard.integer(forKey: "maxDuration")
        
        maxDurationTextField.stringValue = "\(maxDuration/60)"

        if let keynote = keynote{
            self.keynoteTextField.stringValue = keynote.path
            self.keynotFilePath = String(format: getFileName, keynote.path)
        }
        
        //hidden tulisan ditengah
        historyPlaceHolderText.isHidden = true
        //listPastHistory2.isHidden = true
        
        
        //let data: [cPractice] = CoreDataManager.fetchPractices()
        keynotes = CoreDataManager.kelompokinByKeynote()
        
        
        cekData()
        
        
        
        
        // add NIb to NSCollection View
//        let nibPastHistory1 = NSNib(nibNamed: "viewPastHistory1", bundle: nil)
//        listPastHistory1.register(nibPastHistory1, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory1"))
//
//        let nibPastHistory2 = NSNib(nibNamed: "viewPastHistory2", bundle: nil)
//        listPastHistory2.register(nibPastHistory2, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory2"))
//
//        let nibPastHistory3 = NSNib(nibNamed: "viewPastHistory3", bundle: nil)
//        listPastHistory3.register(nibPastHistory3, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory3"))
//
//        let nibPastHistory4 = NSNib(nibNamed: "viewPastHistory4", bundle: nil)
//        listPastHistory4.register(nibPastHistory4, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory4"))
        
        /////// CEK YA BRADER
        //showDataListHistory4.append(dataListHistory4.init(valueCurrentTime4: "00:00", valueMaxTime4: "2:58", nameTextAnalisa4: dat))
        showDataListHistory4.append(dataListHistory4.init(nameAudioFile: "01BloodAndWine", valueCurrentTime4: "00:00", valueMaxTime4: "2:58", nameTextAnalisa4: "Get Gud Son"))
        showDataListHistory4.append(dataListHistory4.init(nameAudioFile: "10SilverForMonsters", valueCurrentTime4: "00:00", valueMaxTime4: "2:20", nameTextAnalisa4: "Le Le Le Le Le"))
        
        
        //showDataListHistory3[0].setDataListHistory4(setValueDataList4: showDataListHistory4[0], amePresentationTitle3: "terakhir ketiga 1")
        //showDataListHistory3[0].setDataListHistory4(setValueDataList4: showDataListHistory4[1], amePresentationTitle3: "terakhir ketiga 1")
        
        
        //coba masukin data dummy rekaman
        
        //coba masukin data dummy di nscollection paling kanan
        showDataListHistory3.append(dataListHistory3.init(namePresentationTitle3: "geralt", namePptView3: "Rectangleppt1", valueTimePresentation3: "10:00:00", nameNotifView3: "rectanglered", nameNotifViewNumber3: 3))
        showDataListHistory3.append(dataListHistory3.init(namePresentationTitle3: "terakhir ketiga 2", namePptView3: "Rectangleppt1", valueTimePresentation3: "20:00:00", nameNotifView3: "rectanglered", nameNotifViewNumber3: 3))
            showDataListHistory3.append(dataListHistory3.init(namePresentationTitle3: "terakhir ketiga 3", namePptView3: "Rectangleppt1", valueTimePresentation3: "30:00:00", nameNotifView3: "rectanglered", nameNotifViewNumber3: 3))
        
        //masukin data yang ke 4 ke ketiga
        showDataListHistory3[0].setDataListHistory4(setValueDataList4: showDataListHistory4[0], namePresentationTitle3: "geralt")
        showDataListHistory3[1].setDataListHistory4(setValueDataList4: showDataListHistory4[1], namePresentationTitle3: "terakhir ketiga 2")
        
        
        
        
        //coba masukin data dummy di ns collection kedua / tengah
        showDataListHistory2.append(dataListHistory2.init(namePresentationTitle2: "kamu yang kedua 1", namePptView2: "Rectangleppt2", valueTimePresentation2: "40:00:00", nameNotifView2: "rectanglered", nameNotifViewNumber2: 2))
        showDataListHistory2.append(dataListHistory2.init(namePresentationTitle2: "kamu yang kedua 2", namePptView2: "Rectangleppt2", valueTimePresentation2: "50:00:00", nameNotifView2: "rectanglered", nameNotifViewNumber2: 2))
        showDataListHistory2.append(dataListHistory2.init(namePresentationTitle2: "kamu yang kedua 3", namePptView2: "Rectangleppt2", valueTimePresentation2: "60:00:00", nameNotifView2: "rectanglered", nameNotifViewNumber2: 2))
        showDataListHistory2.append(dataListHistory2.init(namePresentationTitle2: "kamu yang kedua2 4", namePptView2: "Rectangleppt2", valueTimePresentation2: "70:00:00", nameNotifView2: "rectanglered", nameNotifViewNumber2: 2))
        
        
        
        //masukin data dummy datalist 3 ke datalist 2
        showDataListHistory2[0].setDataListHistory3(setValueDataList3: showDataListHistory3[0], namePresentationTitle2: "kamu yang kedua 1")
        showDataListHistory2[0].setDataListHistory3(setValueDataList3: showDataListHistory3[1], namePresentationTitle2: "kamu yang kedua 1")
        showDataListHistory2[1].setDataListHistory3(setValueDataList3: showDataListHistory3[2], namePresentationTitle2: "kamu yang kedua 2")
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
        listPastHistory4.delegate = self
        listPastHistory4.dataSource = self
        
        setName()
        setPastHistory1()
        //setHiddenCollectionView()
        print(collectionviewhidden2)
        //print(showDataListHistory1[index])
        
        NotificationCenter.default.addObserver(self, selector: #selector(onCloseKeynoteTimer), name: .didCloseKeynoteTimer, object: nil)
    }
    func cekData(){
        if keynotes.isEmpty{
            historyPlaceHolderText.isHidden = false
            verticalLine1.isHidden = true
            verticalLine2.isHidden = true
            verticalLine3.isHidden = true
        }else {
            historyPlaceHolderText.isHidden = true
            verticalLine1.isHidden = false
            verticalLine2.isHidden = true
            verticalLine3.isHidden = true
        }
    }
    
    
    @objc func onCloseKeynoteTimer(){
        self.view.window?.setIsVisible(true)
        keynotes = CoreDataManager.kelompokinByKeynote()
        cekData()
        listPastHistory1.reloadData()
        //data = CoreDataManager.fetchPractices()
        //self.view.window.
    }
    
    //membuat background di nscollection clear, default deep black
    func setPastHistory1(){
        listPastHistory1.backgroundColors = [NSColor.clear]
        listPastHistory2.backgroundColors = [NSColor.clear]
        listPastHistory3.backgroundColors = [NSColor.clear]
        listPastHistory4.backgroundColors = [NSColor.clear]
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
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = ["key"]
        openPanel.begin { (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                //Do what you will
                //If there's only one URL, surely 'openPanel.URL'
                //but otherwise a for loop works
                UserDefaults.standard.set(openPanel.url, forKey: "keynoteFilePath")

                if let resultString = openPanel.url?.path {
                    self.keynoteTextField.stringValue = resultString
                    self.keynotFilePath = String(format: getFileName, resultString)
                }
                
            }
        }
    }
    
    @IBAction func onStartPractice(_ sender: NSButton) {
        let script = NSAppleScript(source: keynotFilePath)
        var error = NSDictionary?.none
        script?.executeAndReturnError(&error)
        print(error)
        
        UserDefaults.standard.set(duraationsInSeconds, forKey: "maxDuration")
        //TODO: Hidden Home.storyboard and show KeynoteTimer.storyboard
        
        self.view.window?.setIsVisible(false)
        performSegue(withIdentifier: "KeynoteTimer", sender: nil)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        print(segue.identifier!)
        if segue.identifier == "KeynoteTimer" {
            if let keynoteTimer = segue.destinationController as? KeynoteTimer {
                keynoteTimer.homeView = self.view
            }
        }
    }
    
    
    
    @IBOutlet weak var timerStepper: NSStepper!
    @IBAction func onStepperChange(_ sender: NSStepper) {
        sender.increment = 1
        maxDurationTextField.stringValue = String(timerStepper.integerValue)
        duraationsInSeconds = timerStepper.integerValue*60
    }
    
    
//    func hexStringToUIColor (hex:String) -> NSColor {
//        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//
//        if (cString.hasPrefix("#")) {
//            cString.remove(at: cString.startIndex)
//        }
//
//        if ((cString.count) != 6) {
//            return UIColor.gray
//        }
//
//        var rgbValue:UInt64 = 0
//        Scanner(string: cString).scanHexInt64(&rgbValue)
//
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }

}

extension HomeViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {

    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        //guard let index = indexListPastHistory1 else {return 0}
        //guard let index2 = indexListPastHistory2 else {return 0}
        //guard let index3 = indexListPastHistory3 else {return 0}
        
        if (collectionView == listPastHistory2){
            guard let index = indexListPastHistory1 else {return 0}
//            return showDataListHistory1[index].getDataListHistory2()
            return keynotes[index].practices.count
        }else if (collectionView == listPastHistory3){
            guard let index = indexListPastHistory1 else {return 0}
            guard let index2 = indexListPastHistory2 else {return 0}
            return keynotes[index].practices[index2].slides.count
            //return showDataListHistory2[index].getDataListHistory3()
            
        }else if (collectionView == listPastHistory4){
            guard let index = indexListPastHistory1 else {return 0}
            guard let index2 = indexListPastHistory2 else {return 0}
            guard let index3 = indexListPastHistory3 else {return 0}
            return keynotes[index].practices[index2].slides[index3].WPMs.count
            //return showDataListHistory3[index].getDataListHistory4()
        }
        
        return keynotes.count
}
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        //guard let indexCollection2 = indexListPastHistory1 else {return NSCollectionViewItem()}
        //guard let indexCollection3 = indexListPastHistory2 else {return NSCollectionViewItem()}
        
        if (collectionView == listPastHistory1){
            let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory1"), for: indexPath) as! viewPastHistory1
            
            //guard let indexCollection2 = indexListPastHistory1 else {return NSCollectionViewItem()}
            
                    //item.presentationTitle.stringValue =
                    item.presentationTitle.stringValue = keynotes[indexPath.item].keynoteName.deletingPathExtension().lastPathComponent
                    item.pptView.image = NSImage(contentsOf: keynotes[indexPath.item].keynotePreview)
            //        item.presentationTitle.stringValue = showDataListHistory1[indexPath.item].namePresentationTitle
            //        item.pptView.image = NSImage(named: showDataListHistory1[indexPath.item].namePptView)
            //        //item.pptView.image = NSImage(named: showDataListHistory1[indexPath.item].namePptView)
            //        item.notifView.image = NSImage(named: showDataListHistory1[indexPath.item].nameNotifView)
            //        item.notifViewNumber.stringValue = "\(showDataListHistory1[indexPath.item].nameNotifViewNumber)"
            return item
        }
        else if (collectionView == listPastHistory2){
            let item2 = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory2"), for: indexPath) as! viewPastHistory2
            
            guard let indexCollection2 = indexListPastHistory1 else {return NSCollectionViewItem()}
            //guard let indexCollection2 = indexListPastHistory1 else {return NSCollectionViewItem()}

//            item2.presentationTitle2.stringValue =
//                showDataListHistory1[indexCollection2].valueDatalistHistory2[indexPath.item].namePresentationTitle2
            
            
            item2.presentationTitle2.stringValue = keynotes[indexCollection2].practices[indexPath.item].keynoteName.deletingPathExtension().lastPathComponent
            
            //item2.presentationTitle2.stringValue = keynotes[indexCollection2].practices[indexPath.item].keynoteName.deletingPathExtension().lastPathComponent
            
//            item2.pptView2.image = NSImage(named: showDataListHistory1[indexPath.section].valueDatalistHistory2[indexPath.item].namePptView2)
            item2.pptView2.image = NSImage(contentsOf: keynotes[indexCollection2].practices[indexPath.item].keynotePreview)
            
//            item2.notifView2.image = NSImage(named: showDataListHistory1[indexCollection2].valueDatalistHistory2[indexPath.item].nameNotifView2)
//            item2.notifViewNumber2.stringValue = "\(showDataListHistory1[indexCollection2].valueDatalistHistory2[indexPath.item].nameNotifViewNumber2)"
            
            let interval = keynotes[indexCollection2].practices[indexPath.item].totalTime
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.unitsStyle = .abbreviated
            let formatterToString = formatter.string(from: TimeInterval(interval))
            
            item2.timePresentation2.stringValue = formatterToString ?? "error"
            
            return item2
            
        }else if (collectionView == listPastHistory3){
            
            let item3 = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory3"), for: indexPath) as! viewPastHistory3
            
            guard let indexCollection2 = indexListPastHistory1 else {return NSCollectionViewItem()}
            guard let indexCollection3 = indexListPastHistory2 else {return NSCollectionViewItem()}
            
            
            item3.presentationTitle3.stringValue = "Slide \(keynotes[indexCollection2].practices[indexCollection3].slides[indexPath.item].number)"
            item3.pptView3.image = NSImage(contentsOf: keynotes[indexCollection2].practices[indexCollection3].slides[indexPath.item].preview)
            
            let interval = keynotes[indexCollection2].practices[indexCollection3].slides[indexPath.item].time
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.unitsStyle = .abbreviated
            let formatterToString = formatter.string(from: TimeInterval(interval))
            
            item3.timePresentation3.stringValue = formatterToString ?? "error"
//            item3.presentationTitle3.stringValue = showDataListHistory2[indexCollection3].valueDatalistHistory3[indexPath.item].namePresentationTitle3
//            item3.pptView3.image = NSImage(named: showDataListHistory2[indexCollection3].valueDatalistHistory3[indexPath.item].namePptView3)
//            //item3.pptview3.image = NSImage(named: showDataListHistory2[indexPath.section].valueDatalistHistory3[indexPath.item].namePptView3)
//            item3.notifView3.image = NSImage(named: showDataListHistory2[indexCollection3].valueDatalistHistory3[indexPath.item].nameNotifView3)
//            item3.notifViewNumber3.stringValue = "\(showDataListHistory2[indexCollection3].valueDatalistHistory3[indexPath.item].nameNotifViewNumber3)"
//            item3.timePresentation3.stringValue = showDataListHistory2[indexCollection3].valueDatalistHistory3[indexPath.item].valueTimePresentation3
            return item3
            
        } else if (collectionView == listPastHistory4){
            let item4 = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory4"), for: indexPath) as! viewPastHistory4
            
            guard let indexCollection2 = indexListPastHistory1 else {return NSCollectionViewItem()}
            guard let indexCollection3 = indexListPastHistory2 else {return NSCollectionViewItem()}
            guard let indexCollection4 = indexListPastHistory3 else {return NSCollectionViewItem()}
            
            //item4.urlAudio = keynotes[indexCollection2].practices[indexCollection3].slides[indexCollection4].WPMs[indexPath.item].audioPath
            
            let cekAnalisa = keynotes[indexCollection2].practices[indexCollection3].slides[indexCollection4].WPMs[indexPath.item].wordsPerMinute
            
            if cekAnalisa > 170 {
                item4.urlAudio = keynotes[indexCollection2].practices[indexCollection3].slides[indexCollection4].WPMs[indexPath.item].audioPath
                item4.setAudio()
                item4.textAnalisa.stringValue = "Your going too fast,"
            }else if cekAnalisa < 140 {
                item4.urlAudio = keynotes[indexCollection2].practices[indexCollection3].slides[indexCollection4].WPMs[indexPath.item].audioPath
                item4.textAnalisa.stringValue = "Your going too slow, be faster"
                item4.setAudio()
            }
            //else {
                //item4.collectionView?.isHidden = true
            //}
            
            
            //item4.currentTime4.stringValue = showDataListHistory3[indexCollection4].valueDatalistHistory4[indexPath.item].valueCurrentTime4
            //item4.maxTime4.stringValue = showDataListHistory3[indexCollection4].valueDatalistHistory4[indexPath.item].valueMaxTime4
//            item4.textAnalisa.stringValue = showDataListHistory3[indexCollection4].valueDatalistHistory4[indexPath.item].nameTextAnalisa4
//            // disini keambil tapi gak keupdate di cell.
//            item4.playingAudio = showDataListHistory3[indexCollection4].valueDatalistHistory4[indexPath.item].nameAudioFile
//            item4.setAudio()
            //item4.playingAudio = "01BloodAndWine"
            
            //item4.currentTime4.stringValue = showDataListHistory3[indexPath.item].valueData
            
//            item4.currentTime4.stringValue = showDataListHistory3[indexPath.section].valueDatalistHistory4[indexPath.item].valueCurrentTime4
//            item4.maxTime4.stringValue = showDataListHistory3[indexPath.section].valueDatalistHistory4[indexPath.item].valueMaxTime4
//            item4.textAnalisa.stringValue = showDataListHistory3[indexPath.section].valueDatalistHistory4[indexPath.item].nameTextAnalisa4
            
            return item4
        }
        return NSCollectionViewItem()
    }
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if (collectionView == listPastHistory1){
            indexListPastHistory1 = indexPaths.first?.item
            listPastHistory1.item(at: indexListPastHistory1!)?.view.layer?.backgroundColor = CGColor(red: 0, green: 0x62/0xFF, blue: 0xCC/0xFF, alpha: 1)
            //listPastHistory2.item(at: indexListPastHistory1!)?.view.layer?.backgroundColor = .clear
            //listPastHistory3.item(at: indexListPastHistory1!)?.view.layer?.backgroundColor = .clear
            
            //listPastHistory1.reloadData()
            //listPastHistory2.backgroundColors = CGColor(red: 0, green: 0x62/0xFF, blue: 0xCC/0xFF, alpha: 1) as! [NSColor]
            //listPastHistory2.backgroundColors = NSColor(.c)
            verticalLine2.isHidden = false
            listPastHistory2.reloadData()
            indexListPastHistory2 = nil
            verticalLine3.isHidden = true
            listPastHistory3.reloadData()
            indexListPastHistory3 = nil
            listPastHistory4.reloadData()
        }else if (collectionView == listPastHistory2){
            
            //listPastHistory2.item(at: indexListPastHistory2!)?.view.layer?.backgroundColor = .clear
            indexListPastHistory2 = indexPaths.first?.item
            //listPastHistory1.item(at: indexListPastHistory1!)?.view.layer?.backgroundColor = .clear
            listPastHistory2.item(at: indexListPastHistory2!)?.view.layer?.backgroundColor = CGColor(red: 0, green: 0x62/0xFF, blue: 0xCC/0xFF, alpha: 1)
            //listPastHistory3.item(at: indexListPastHistory1!)?.view.layer?.backgroundColor = .clear
            verticalLine3.isHidden = false
            listPastHistory3.reloadData()
            indexListPastHistory3 = nil
            listPastHistory4.reloadData()
        }else if (collectionView == listPastHistory3){
            indexListPastHistory3 = indexPaths.first?.item
            listPastHistory3.item(at: indexListPastHistory3!)?.view.layer?.backgroundColor = CGColor(red: 0, green: 0x62/0xFF, blue: 0xCC/0xFF, alpha: 1)
            listPastHistory4.reloadData()
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        if (collectionView == listPastHistory1){
            indexListPastHistory1 = indexPaths.first?.item
            listPastHistory1.item(at: indexListPastHistory1!)?.view.layer?.backgroundColor = .clear
            //listPastHistory1.reloadData()
            listPastHistory2.reloadData()
            //indexListPastHistory2 = nil
            listPastHistory3.reloadData()
            //indexListPastHistory3 = nil
            listPastHistory4.reloadData()
        }else if (collectionView == listPastHistory2){
            indexListPastHistory2 = indexPaths.first?.item
            listPastHistory2.item(at: indexListPastHistory2!)?.view.layer?.backgroundColor = .clear
            listPastHistory3.reloadData()
            //indexListPastHistory3 = nil
            listPastHistory4.reloadData()
        }else if (collectionView == listPastHistory3){
            indexListPastHistory3 = indexPaths.first?.item
            listPastHistory3.item(at: indexListPastHistory3!)?.view.layer?.backgroundColor = .clear
            listPastHistory4.reloadData()
        }
        }
    }

extension Notification.Name{
    static let didCloseKeynoteTimer = NSNotification.Name(rawValue: "onCloseKeynoteTimer")
}





