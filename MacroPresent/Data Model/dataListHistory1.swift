//
//  dummyListHistory1.swift
//  MacroPresent
//
//  Created by Rais Mohamad Najib on 10/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Foundation

class dataListHistory1 {
    var namePresentationTitle: String
    var namePptView: String
    var nameNotifView: String
    var nameNotifViewNumber: Int
    var valueDatalistHistory2 = [dataListHistory2]()
    
    init(namePresenttationTitle: String, namePptView: String, nameNotifView: String, nameNotifViewNumber: Int) {
        self.namePresentationTitle = namePresenttationTitle
        self.namePptView = namePptView
        self.nameNotifView = nameNotifView
        self.nameNotifViewNumber = nameNotifViewNumber
    }
    
    func setDataListHistory2(setValueDataList2: dataListHistory2, namePresentationTitle: String){
        if namePresentationTitle == self.namePresentationTitle{
            self.valueDatalistHistory2.append(setValueDataList2)
        }
    }
    
    func getDataListHistory2() -> Int {
        return valueDatalistHistory2.count
    }
    
//    func setDataListHistory3(setValueDataList3: dataListHistory3, namePresentationTitle2: String ){
//        if namePresentationTitle2 == self.namePresentationTitle2 {
//            self.valueDatalistHistory3.append(setValueDataList3)
//        }
//    }
//
//    func getDatalistHistory3() -> Int {
//        return valueDatalistHistory3.count
//    }
}

