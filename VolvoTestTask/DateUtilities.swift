//
//  DateUtilities.swift
//  VolvoTestTask
//
//  Created by Victor Rosas on 10/21/18.
//  Copyright © 2018 Victor Rosas. All rights reserved.
//

import Foundation

class DateUtilities{
    class func getTomorrowsDate()->String{
        
        var dateComponents = DateComponents()
        dateComponents.setValue(1, for: .day)
        
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: dateComponents, to:today)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        return dateFormatter.string(from: tomorrow!)
    }
}
