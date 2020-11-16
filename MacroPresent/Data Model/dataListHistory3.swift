//
//  dataListHistory3.swift
//  MacroPresent
//
//  Created by Rais Mohamad Najib on 10/11/20.
//  Copyright © 2020 CKCK. All rights reserved.
//

import Foundation

class dataListHistory3 {
    var namePresentationTitle3: String
    var namePptView3: String
    var valueTimePresentation3: String
    var nameNotifView3: String
    var nameNotifViewNumber3: Int
    var valueDatalistHistory4 = [dataListHistory4]()
    
    init(namePresentationTitle3: String, namePptView3: String, valueTimePresentation3: String, nameNotifView3: String, nameNotifViewNumber3: Int ) {
        self.namePresentationTitle3 = namePresentationTitle3
        self.namePptView3 = namePptView3
        self.valueTimePresentation3 = valueTimePresentation3
        self.nameNotifView3 = nameNotifView3
        self.nameNotifViewNumber3 = nameNotifViewNumber3
    }
    
    func setDataListHistory4(setValueDataList4: dataListHistory4, namePresentationTitle3: String){
        if namePresentationTitle3 == self.namePresentationTitle3 {
            self.valueDatalistHistory4.append(setValueDataList4)
        }
    }
    
    func getDataListHistory4() -> Int {
        return valueDatalistHistory4.count
    }
    
    //    func setDataListHistory3(setValueDataList3: dataListHistory3, namePresentationTitle2: String ){
    //        if namePresentationTitle2 == self.namePresentationTitle2 {
    //            self.valueDatalistHistory3.append(setValueDataList3)
    //        }
    //    }
    //
    //    func getDataListHistory3() -> Int {
    //        return valueDatalistHistory3.count
    //    }
    
    
    
}
