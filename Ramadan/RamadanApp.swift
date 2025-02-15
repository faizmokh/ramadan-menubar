//
//  RamadanApp.swift
//  Ramadan
//
//  Created by Faiz Mokhtar on 15/02/2025.
//

import SwiftUI

@main
struct RamadanApp: App {
    var body: some Scene {
        MenuBarExtra(
            "Ramadan Countdown",
            systemImage: "moonphase.waning.crescent"
        ) {
            MainView()
                .frame(width: 300, height: 180)
        }
        .menuBarExtraStyle(.window)
    }
}
