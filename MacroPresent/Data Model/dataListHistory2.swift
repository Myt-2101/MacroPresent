//
//  dataListHistory2.swift
//  MacroPresent
//
//  Created by Rais Mohamad Najib on 10/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Foundation

class dataListHistory2 {
    var namePresentationTitle2: String
    var namePptView2: String
    var valueTimePresentation2: String
    var nameNotifView2: String
    var nameNotifViewNumber2: Int
    var valueDatalistHistory3 = [dataListHistory3]()
    
    init(namePresentationTitle2: String, namePptView2: String, valueTimePresentation2: String, nameNotifView2: String, nameNotifViewNumber2: Int  ) {
        self.namePresentationTitle2 = namePresentationTitle2
        self.namePptView2 = namePptView2
        self.valueTimePresentation2 = valueTimePresentation2
        self.nameNotifView2 = nameNotifView2
        self.nameNotifViewNumber2 = nameNotifViewNumber2
    }
    
    
    func setDataListHistory3(setValueDataList3: dataListHistory3, namePresentationTitle2: String ){
        if namePresentationTitle2 == self.namePresentationTitle2 {
            self.valueDatalistHistory3.append(setValueDataList3)
        }
    }
    
    func getDataListHistory3() -> Int {
        return valueDatalistHistory3.count
    } 
}
