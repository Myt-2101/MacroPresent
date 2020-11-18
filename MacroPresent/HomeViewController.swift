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
    @IBOutlet weak var needImprovement: NSTextField!
    
    var collectionviewhidden2:Int = 0
    var collectionviewhideen3:Int = 0
    var nilai:Int?
    
//    var data: [cPractice] = CoreDataManager.fetchPractices()
    
    var keynotes: [Keynote] = [Keynote]()
    //var valueListPstHistory = [dataListHistoryNext]()
    
    
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
        setNeedImprovement()
        
        
        
        
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
        reverseArray()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onCloseKeynoteTimer), name: .didCloseKeynoteTimer, object: nil)
    }
    
    func reverseArray(){
        keynotes.reverse()
    }
    
    
    func cekData(){
        if keynotes.isEmpty{
            historyPlaceHolderText.isHidden = false
            verticalLine1.isHidden = true
            verticalLine2.isHidden = true
            verticalLine3.isHidden = true
            needImprovement.isHidden = true
        }else {
            historyPlaceHolderText.isHidden = true
            verticalLine1.isHidden = false
            verticalLine2.isHidden = true
            verticalLine3.isHidden = true
            needImprovement.isHidden = true
        }
    }
    
    func setNeedImprovement() {
        needImprovement.font = .systemFont(ofSize: 20)
        needImprovement.font = .boldSystemFont(ofSize: 20)
    }
    
    
    @objc func onCloseKeynoteTimer(){
        self.view.window?.setIsVisible(true)
        keynotes = CoreDataManager.kelompokinByKeynote()
        cekData()
        reverseArray()
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
        //mmengecek satu2 collectionview
        if (collectionView == listPastHistory2){
            guard let index = indexListPastHistory1 else {return 0}
         
            return keynotes[index].practices.count
        }else if (collectionView == listPastHistory3){
            guard let index = indexListPastHistory1 else {return 0}
            guard let index2 = indexListPastHistory2 else {return 0}
            return keynotes[index].practices[index2].slides.count
            
        }else if (collectionView == listPastHistory4){
            guard let index = indexListPastHistory1 else {return 0}
            guard let index2 = indexListPastHistory2 else {return 0}
            guard let index3 = indexListPastHistory3 else {return 0}
            return keynotes[index].practices[index2].slides[index3].WPMs.count
        }
        return keynotes.count
    }
    
    func getTotalMistake(_ indexPath: IndexPath) -> Int{
        let keynote = keynotes[indexPath.item]
        
        var total = 0
        
        for practice in keynote.practices{
            for slide in practice.slides{
                for wpm in slide.WPMs{
                    if wpm.wordsPerMinute < 140 || wpm.wordsPerMinute > 170 {
                        total += 1
                    }
                }
            }
        }
        
        return total
    }
    
    func getPracticeMistake(_ index2: Int, _ indexPath: IndexPath) -> Int{
        let practice = keynotes[index2].practices[indexPath.item]
        
        var total = 0
        
        for slide in practice.slides{
            for wpm in slide.WPMs{
                if wpm.wordsPerMinute < 140 || wpm.wordsPerMinute > 170 {
                    total += 1
                }
            }
        }
        
        return total
    }
    
    func getSlideMistake(_ index2: Int, _ index3: Int, _ indexPath: IndexPath) -> Int{
        let slide = keynotes[index2].practices[index3].slides[indexPath.item]
        
        var total = 0
        
        for wpm in slide.WPMs{
            if wpm.wordsPerMinute < 140 || wpm.wordsPerMinute > 170 {
                total += 1
            }
        }
        
        return total
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
                
        if (collectionView == listPastHistory1){
            let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory1"), for: indexPath) as! viewPastHistory1
            item.presentationTitle.stringValue = keynotes[indexPath.item].keynoteName.deletingPathExtension().lastPathComponent
            item.pptView.image = NSImage(contentsOf: keynotes[indexPath.item].keynotePreview)
            
            let mistakes = getTotalMistake(indexPath)
            if mistakes <= 0{
                item.notifView.isHidden = true
                item.notifViewNumber.isHidden = true
            } else {
                item.notifView.isHidden = false
                item.notifViewNumber.isHidden = false
                item.notifViewNumber.stringValue = "\(mistakes)"
            }
            
            return item
        }else if (collectionView == listPastHistory2){
            let item2 = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory2"), for: indexPath) as! viewPastHistory2
            
            // untuk memastikan index yang kepilih sudah masuk
            guard let indexCollection2 = indexListPastHistory1 else {return NSCollectionViewItem()}

//            item2.presentationTitle2.stringValue = keynotes[indexCollection2].practices[indexPath.item].keynoteName.deletingPathExtension().lastPathComponent
            item2.presentationTitle2.stringValue = "Practice \(indexPath.item + 1)"
            item2.pptView2.image = NSImage(contentsOf: keynotes[indexCollection2].practices[indexPath.item].keynotePreview)
            
            //fungsi membuat int ke dalam bentuk menit detik
            let interval = keynotes[indexCollection2].practices[indexPath.item].totalTime
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.unitsStyle = .abbreviated
            let formatterToString = formatter.string(from: TimeInterval(interval))
            
            item2.timePresentation2.stringValue = formatterToString ?? "error"
            
            let mistakes = getPracticeMistake(indexCollection2, indexPath)
            if mistakes <= 0{
                item2.notifView2.isHidden = true
                item2.notifViewNumber2.isHidden = true
            } else {
                item2.notifView2.isHidden = false
                item2.notifViewNumber2.isHidden = false
                item2.notifViewNumber2.stringValue = "\(mistakes)"
            }
            
            return item2
            
        }else if (collectionView == listPastHistory3){
            
            let item3 = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory3"), for: indexPath) as! viewPastHistory3
            
            //memastikan index masuk tidak 0
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
            
            let mistakes = getSlideMistake(indexCollection2, indexCollection3, indexPath)
            if mistakes <= 0{
                item3.notifView3.isHidden = true
                item3.notifViewNumber3.isHidden = true
            } else {
                item3.notifView3.isHidden = false
                item3.notifViewNumber3.isHidden = false
                item3.notifViewNumber3.stringValue = "\(mistakes)"
            }
            
            return item3
            
        } else if (collectionView == listPastHistory4){
            let item4 = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "viewPastHistory4"), for: indexPath) as! viewPastHistory4
            
            //memastikan bahwa index tidak kosong
            guard let indexCollection2 = indexListPastHistory1 else {return NSCollectionViewItem()}
            guard let indexCollection3 = indexListPastHistory2 else {return NSCollectionViewItem()}
            guard let indexCollection4 = indexListPastHistory3 else {return NSCollectionViewItem()}
            
            let cekAnalisa = keynotes[indexCollection2].practices[indexCollection3].slides[indexCollection4].WPMs[indexPath.item].wordsPerMinute
            
            if cekAnalisa > 170 {
                item4.urlAudio = keynotes[indexCollection2].practices[indexCollection3].slides[indexCollection4].WPMs[indexPath.item].audioPath
                item4.setAudio()
                item4.textAnalisa.stringValue = "You're going too fast"
            }else if cekAnalisa < 140 {
                item4.urlAudio = keynotes[indexCollection2].practices[indexCollection3].slides[indexCollection4].WPMs[indexPath.item].audioPath
                item4.textAnalisa.stringValue = "You're going too slow"
                item4.setAudio()
            }
            return item4
        }
        return NSCollectionViewItem()
    }
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if (collectionView == listPastHistory1){
            indexListPastHistory1 = indexPaths.first?.item
            //membuat yang dipilih bewarna biru
            listPastHistory1.item(at: indexListPastHistory1!)?.view.layer?.backgroundColor = CGColor(red: 0, green: 0x62/0xFF, blue: 0xCC/0xFF, alpha: 1)
            verticalLine2.isHidden = false
            listPastHistory2.reloadData()
            indexListPastHistory2 = nil
            verticalLine3.isHidden = true
            listPastHistory3.reloadData()
            indexListPastHistory3 = nil
            needImprovement.isHidden = true
            listPastHistory4.reloadData()
        }else if (collectionView == listPastHistory2){
            
            indexListPastHistory2 = indexPaths.first?.item
            listPastHistory2.item(at: indexListPastHistory2!)?.view.layer?.backgroundColor = CGColor(red: 0, green: 0x62/0xFF, blue: 0xCC/0xFF, alpha: 1)
            verticalLine3.isHidden = false
            listPastHistory3.reloadData()
            indexListPastHistory3 = nil
            needImprovement.isHidden = true
            listPastHistory4.reloadData()
        }else if (collectionView == listPastHistory3){
            indexListPastHistory3 = indexPaths.first?.item
            listPastHistory3.item(at: indexListPastHistory3!)?.view.layer?.backgroundColor = CGColor(red: 0, green: 0x62/0xFF, blue: 0xCC/0xFF, alpha: 1)
            needImprovement.isHidden = false
            listPastHistory4.reloadData()
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        if (collectionView == listPastHistory1){
            indexListPastHistory1 = indexPaths.first?.item
            listPastHistory1.item(at: indexListPastHistory1!)?.view.layer?.backgroundColor = .clear
            listPastHistory2.reloadData()
            listPastHistory3.reloadData()
            listPastHistory4.reloadData()
        }else if (collectionView == listPastHistory2){
            indexListPastHistory2 = indexPaths.first?.item
            listPastHistory2.item(at: indexListPastHistory2!)?.view.layer?.backgroundColor = .clear
            listPastHistory3.reloadData()
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





