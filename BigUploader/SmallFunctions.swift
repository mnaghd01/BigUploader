//
//  SmallFunctions.swift
//  BigUploader
//
//  Created by Mehdi Naghdi Tam on 7/17/18.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class SmallFunctions {
    
    func giveDate()-> String {
        let date = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let us = dateFormatterGet.string(from: date)
        return us
        
    }
}
