//
//  RamadanApp.swift
//  Ramadan
//
//  Created by Faiz Mokhtar on 15/02/2025.
//

import SwiftUI

@main
struct RamadanApp: App {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some Scene {
        MenuBarExtra {
            MainView()
                .frame(width: 300, height: 180)
        } label: {
            Text(viewModel.displayText)
        }
        .menuBarExtraStyle(.window)
    }
}
