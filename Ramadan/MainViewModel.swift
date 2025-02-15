//
//  MainViewModel.swift
//  Ramadan
//
//  Created by Faiz Mokhtar on 15/02/2025.
//

import Combine
import Foundation

class MainViewModel: ObservableObject {
    @Published private(set) var displayText = ""
    
    private var timer: Timer?
    private let dateWorker: DateWorker
    
    init(dateWorker: DateWorker = DateWorker()) {
        self.dateWorker = dateWorker
        updateDisplayText()
        startTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
}

private extension MainViewModel {
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.updateDisplayText()
        }
    }
    
    func updateDisplayText() {
        if dateWorker.isRamadan() {
            displayText = dateWorker.currentHijriDate()
        } else {
            // Display days until Ramadan. 1 day before Ramadan, display "Tomorrow"
            let daysUntilRamadan = dateWorker.daysUntilRamadan()
            if daysUntilRamadan == 1 {
                displayText = "Tomorrow"
            } else {
                displayText = "\(daysUntilRamadan) days"
            }
        }
    }
}
