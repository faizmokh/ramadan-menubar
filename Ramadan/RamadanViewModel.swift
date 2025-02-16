//
//  MainViewModel.swift
//  Ramadan
//
//  Created by Faiz Mokhtar on 15/02/2025.
//

import Combine
import Foundation

class RamadanViewModel: ObservableObject {
    @Published private(set) var displayText = ""
    
    @Published private(set) var displayLongText = ""
    
    private let dateWorker: DateWorker
    
    init(dateWorker: DateWorker = DateWorker()) {
        self.dateWorker = dateWorker
        updateDisplayText()
        
        // update display on date change
        NotificationCenter.default.addObserver(self, selector: #selector(didCalendarDayChanged), name: .NSCalendarDayChanged, object: nil)
    }
    
    @objc func didCalendarDayChanged() {
        updateDisplayText()
    }
}

private extension RamadanViewModel {
    func updateDisplayText() {
        if dateWorker.isRamadan() {
            displayText = dateWorker.currentHijriDate()
            displayLongText = dateWorker.currentHijriDate()
        } else {
            let daysUntilRamadan = dateWorker.daysUntilRamadan()
            if daysUntilRamadan == 1 {
                displayText = "Tomorrow (\(dateWorker.ramadanInGregorianDate()))"
                displayLongText = "1 day until Ramadan"
            } else {
                displayText = "\(daysUntilRamadan) days (\(dateWorker.ramadanInGregorianDate()))"
                displayLongText = "\(daysUntilRamadan) days until Ramadan"
            }
            
        }
    }
}
