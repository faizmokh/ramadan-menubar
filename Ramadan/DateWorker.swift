//
//  DateWorker.swift
//  Ramadan
//
//  Created by Faiz Mokhtar on 15/02/2025.
//

import Foundation

class DateWorker {
    private let calendar: Calendar
    private let currentDate: () -> Date
    
    init(
        calendar: Calendar = Calendar(identifier: .islamic),
        currentDate: @escaping () -> Date = { .now }
    ) {
        self.calendar = calendar
        self.currentDate = currentDate
    }
    
    func daysUntilRamadan() -> Int {
        let date = currentDate()
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.month = 9 // Ramadan month is the 9th month
        components.day = 1 // Ramadan starts on the 1st day
        
        guard let ramadanDate = calendar.date(from: components) else {
            return 0
        }
        
        // If Ramadan has passed, calculate the next year's Ramadan
        if ramadanDate < date {
            guard let nextRamadanDate = calendar.date(byAdding: .year, value: 1, to: ramadanDate) else {
                return 0
            }
            return calendar.dateComponents([.day], from: date, to: nextRamadanDate).day ?? 0
        } else {
            return calendar.dateComponents([.day], from: date, to: ramadanDate).day ?? 0
        }
    }
    
    func currentHijriDate() -> String {
        let date = currentDate()
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateStyle = .full
        formatter.locale = Locale(identifier: "ar")
        return formatter.string(from: date)
    }
    
    func isRamadan() -> Bool {
        let date = currentDate()
        let components = calendar.dateComponents([.month], from: date)
        return components.month == 9
    }
}
