//
//  RamadanApp.swift
//  Ramadan
//
//  Created by Faiz Mokhtar on 15/02/2025.
//

import SwiftUI

@main
struct RamadanApp: App {
    @StateObject private var viewModel = RamadanViewModel()
    
    var body: some Scene {
        MenuBarExtra {
            Text(viewModel.displayLongText)
            Divider()
            Button("Settings...", action: openSettings)
                .keyboardShortcut(",", modifiers: [.command])
            Button("Quit", action: quit)
                .keyboardShortcut("q", modifiers: [.command])
        } label: {
            Text(viewModel.displayText)
        }
    }
}

extension RamadanApp {
    func openSettings() {
        // TODO: Open settings
    }
    func quit() {
        NSApplication.shared.terminate(self)
    }
}
