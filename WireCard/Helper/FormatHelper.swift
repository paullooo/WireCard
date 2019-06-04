//
//  DateHelper.swift
//  WireCard
//
//  Created by Claro on 02/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//


import Foundation

class FormatHelper {
    
    func dateFormater(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-SSS"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.timeZone = TimeZone.current
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date)
        }
        else {
            print("There was an error decoding the string")
        }
        return ""
    }
    func rideElapsedTimer(date: String) -> String {
        let now = Date()
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.month, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 2
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        if let date = dateFormatterGet.date(from: date) {
            return formatter.string(from: date, to: now) ?? ""
        }
        return ""
    }
    
    func currencyFormater(value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        if let formattedAmount = formatter.string(from: NSNumber(value: value)) {
            return formattedAmount
        }
        return ""
    }
    
}
