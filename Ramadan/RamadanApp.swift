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
    
    @Environment(\.openSettings) private var openSettings

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
                openSettings()
            })
                .keyboardShortcut(",", modifiers: [.command])
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
