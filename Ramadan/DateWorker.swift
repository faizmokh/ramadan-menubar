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

    private let settings: SettingsManager
    private let gregorianCalendar: Calendar
    
    private var islamicCalendar: Calendar {
        guard let calendar = IslamicCalendar(rawValue: settings.selectedCalendar) else { return Calendar(identifier: .islamic) }
        var cal = Calendar(identifier: calendar.identifier)
        cal.timeZone = .current
        return cal
    }
    
    private var currentDate: Date {
        let date: Date = .now
        guard let offsetDate = Calendar.current.date(byAdding: .day, value: settings.dayOffset, to: date) else {
            return date
        }
        return offsetDate
    }
    
    init(
        settings: SettingsManager = .shared,
        gregorianCalendar: Calendar = Calendar(identifier: .gregorian)
    ) {
        self.settings = settings
        self.gregorianCalendar = gregorianCalendar
    }
}

extension DateWorker {
    func daysUntilRamadan() -> Int {
        let ramadanDate = getRamadanDate(for: currentDate)
        let isPastRamadan = ramadanDate < currentDate
        return isPastRamadan ? calculateDaysToNextRamadan(from: currentDate, ramadanDate: ramadanDate) : calculateDaysToRamadan(from: currentDate, to: ramadanDate)
    }
    
    func currentHijriDate() -> String {
        let formatter = makeDateFormatter()
        return formatter.string(from: currentDate)
    }
        
    func ramadanInGregorianDate() -> String {
        let ramadanDate = getRamadanDate(for: currentDate)
        let targetDate = ramadanDate < currentDate ? getNextRamadanDate(from: ramadanDate) : ramadanDate
        guard let targetDate else { return "" }
        
        return targetDate.formatted(.dateTime.day().month())
    }
    
    func isRamadan() -> Bool {
        let components = islamicCalendar.dateComponents([.month], from: currentDate)
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
