//
//  Utils.swift
//  FeedsApp
//
//  Created by Vishal on 22/06/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation

class Util {
    
    static func getElapsedInterval(fromDate: Date) -> String {

        let interval = Calendar.current.dateComponents([.year, .month, .day], from: fromDate, to: Date())

        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else {
            return "a moment ago"
        }

    }
    
    static func convertDateFormat(stringDate: String, givenFormat: String, expectedFormat: String) -> String?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = givenFormat
        let date = dateFormatter.date(from: stringDate)
        dateFormatter.dateFormat = expectedFormat
        if let dateNew = date {
            return  dateFormatter.string(from: dateNew)
        } else{
            return nil
        }
    }
    
    static func convertStringToDate(stringDate: String, givenFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = givenFormat
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: stringDate)
    }
}

extension Int {

    func shortNumbersFormat () -> String {
        let numFormatter = NumberFormatter()

        typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "K"),
                                           (100_000.0, 1_000_000.0, "M"),
                                           (100_000_000.0, 1_000_000_000.0, "B")]
                    

        let startValue = Double (abs(self))
        let abbreviation:Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        } ()

        let value = Double(self) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1

        return numFormatter.string(from: NSNumber (value:value))!
    }

}
