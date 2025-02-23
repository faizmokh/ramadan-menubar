//
//  RamadanApp.swift
//  Ramadan
//
//  Created by Faiz Mokhtar on 15/02/2025.
//

import SwiftUI
import Sparkle

@main
struct RamadanApp: App {
    @StateObject private var viewModel = RamadanViewModel()
    
    @Environment(\.openSettings) private var openSettings

    private let updaterController: SPUStandardUpdaterController
    
    init() {
        // If you want to start the updater manually, pass false to startingUpdater and call .startUpdater() later
        // This is where you can also pass an updater delegate if you need one
        updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
    }

    var body: some Scene {
        MenuBarExtra {
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.displayLongText)
                    .fontWeight(.medium)
                if viewModel.shouldShowHijriDate {
                    Text(viewModel.hijriDate)
                        .controlSize(.small)
                        .font(.callout)
                }
            }
            .padding(.vertical, 4)
            Divider()
            Button("Settings...", action: {
                NSApp.activate(ignoringOtherApps: true)
                openSettings()
            })
                .keyboardShortcut(",", modifiers: [.command])
            CheckForUpdatesView(updater: updaterController.updater)
                .keyboardShortcut("u", modifiers: [.command])
            Button("Quit", action: quit)
                .keyboardShortcut("q", modifiers: [.command])
        } label: {
            Text(viewModel.displayText)
        }
        Settings {
            SettingsView()
        }
    }
}

extension RamadanApp {
    func quit() {
        NSApplication.shared.terminate(self)
    }
}
