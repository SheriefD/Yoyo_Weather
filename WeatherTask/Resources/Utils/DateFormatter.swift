//
//  DateFormatter.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation

extension Double {
    func getDayOFTheWeekFromTimeInterval() -> String {
        let date = Date(timeIntervalSince1970: self)
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        }else {  //Get day of the week
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let dayOfWeek = dateFormatter.string(from: date)
            return dayOfWeek
        }
    }
}

