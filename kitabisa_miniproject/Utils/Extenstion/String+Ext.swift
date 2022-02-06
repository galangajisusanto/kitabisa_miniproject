//
//  String+Ext.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import Foundation

extension String {
    
    func toDateFormat() -> String{
        let isoDate = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: isoDate) {
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.locale = Locale(identifier: "id_ID")
            dateFormatterPrint.dateFormat = "dd MMMM yyyy"
            return dateFormatterPrint.string(from: date)
        }
        return "unable to format"
    }
    
    func toDateTimeFormat() -> String{
        let isoDate = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let date = dateFormatter.date(from: isoDate) {
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.locale = Locale(identifier: "id_ID")
            dateFormatterPrint.dateFormat = "dd MMMM yyyy"
            return dateFormatterPrint.string(from: date)
        }
        return "unable to format"
    }
    
}
