//
//  SettingsManager.swift
//  Ramadan
//
//  Created by Faiz Mokhtar on 17/02/2025.
//

import Foundation
import SwiftUI

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
    private init() {}
    
    @AppStorage("selectedCalendar") var selectedCalendar = IslamicCalendar.islamic.rawValue
    @AppStorage("hideDockIcon") var hideDockIcon = false
    @AppStorage("showHijriDate") var showHijriDate = true
    @AppStorage("dayOffset") var dayOffset = 0
}

