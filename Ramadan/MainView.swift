//
//  MainView.swift
//  Ramadan
//
//  Created by Faiz Mokhtar on 15/02/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        VStack {
            Text(viewModel.displayText)
        }
        .padding()
    }
}

#Preview {
    MainView()
}
