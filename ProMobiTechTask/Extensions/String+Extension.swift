//
//  String+Extension.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 01/09/21.
//

import Foundation

enum DateFormat : String {
    
    case YYYYMMDD = "yyyy-MM-dd"
    case DDMMMYYYYWithComma = "dd MMM, yyyy"
    case YYYYMMDDTHHMMSSSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

// Common extension of String
extension String {
    
    func UTCToLocal(currentFormat:String, requiredFormat:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = requiredFormat

        if let d = dt {
            
            return dateFormatter.string(from: d)
        }
        return ""
    }
    
    
}
