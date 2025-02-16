//
//  DateWorker.swift
//  Ramadan
//
//  Created by Faiz Mokhtar on 15/02/2025.
//

import Foundation

class DateWorker {
    private enum Constants {
        static let ramadanMonth = 9
        static let firstDay = 1
        static let arabicLocale = "ar"
    }

    private let islamicCalendar: Calendar
    private let gregorianCalendar: Calendar
    private let currentDate: () -> Date
    
    init(
        calendar: Calendar = Calendar(identifier: .islamic),
        gregorianCalendar: Calendar = Calendar(identifier: .gregorian),
        currentDate: @escaping () -> Date = { .now }
    ) {
        self.islamicCalendar = calendar
        self.currentDate = currentDate
        self.gregorianCalendar = gregorianCalendar
    }
}

extension DateWorker {
    func daysUntilRamadan() -> Int {
        let date = currentDate()
        let ramadanDate = getRamadanDate(for: date)
        let isPastRamadan = ramadanDate < date
        return isPastRamadan ? calculateDaysToNextRamadan(from: date, ramadanDate: ramadanDate) : calculateDaysToRamadan(from: date, to: ramadanDate)
    }
    
    func currentHijriDate() -> String {
        let formatter = makeDateFormatter()
        return formatter.string(from: currentDate())
    }
    
    func ramadanInGregorianDate() -> String {
        let date = currentDate()
        let ramadanDate = getRamadanDate(for: date)
        let targetDate = ramadanDate < date ? getNextRamadanDate(from: ramadanDate) : ramadanDate
        
        guard let targetDate else { return "" }
        
        let components = gregorianCalendar.dateComponents([.day, .month], from: targetDate)
        return "\(components.day ?? 0)/\(components.month ?? 0)"
    }
    
    func isRamadan() -> Bool {
        let components = islamicCalendar.dateComponents([.month], from: currentDate())
        return components.month == Constants.ramadanMonth
    }
}

// MARK: - Private methods

private extension DateWorker {
    func getRamadanDate(for date: Date) -> Date {
        var components = islamicCalendar.dateComponents([.year], from: date)
        components.month = Constants.ramadanMonth
        components.day = Constants.firstDay
        return islamicCalendar.date(from: components) ?? date
    }
    
    func getNextRamadanDate(from date: Date) -> Date? {
        islamicCalendar.date(byAdding: .year, value: 1, to: date)
    }
    
    func calculateDaysToNextRamadan(from date: Date, ramadanDate: Date) -> Int {
       guard let nextRamadanDate = getNextRamadanDate(from: ramadanDate) else { return 0 }
       return calculateDaysToRamadan(from: date, to: nextRamadanDate)
    }
       
   func calculateDaysToRamadan(from date: Date, to ramadanDate: Date) -> Int {
       islamicCalendar.dateComponents([.day], from: date, to: ramadanDate).day ?? 0
   }
    
    func makeDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = islamicCalendar
        formatter.dateStyle = .full
        formatter.locale = Locale(identifier: Constants.arabicLocale)
        return formatter
    }
}
