//
//  SettingsPane.swift
//  Ramadan
//
//  Created by Faiz Mokhtar on 16/02/2025.
//

import SwiftUI
import Settings

enum IslamicCalendar: String, CaseIterable {
    case islamic = "Islamic"
    case islamicCivil = "Islamic (Civil)"
    case islamicTabular = "Islamic (Tabular)"
    case islamicUmmAlQura = "Islamic (Umm al-Qura)"
    
    var identifier: Calendar.Identifier {
        switch self {
        case .islamic:
            return .islamic
        case .islamicCivil:
            return .islamicCivil
        case .islamicTabular:
            return .islamicTabular
        case .islamicUmmAlQura:
            return .islamicUmmAlQura
        }
    }
}

enum SettingsTab: String, CaseIterable {
    case general = "General"
    case about = "About"
}

struct SettingsView: View {
    @AppStorage("selectedSettingsTab") var selectedSettingsTab = SettingsTab.general
    
    var body: some View {
        TabView(selection: $selectedSettingsTab) {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(SettingsTab.general)
            AboutSettingsView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
                .tag(SettingsTab.about)
        }
        .frame(width: 300, height: 200)
    }
}
struct GeneralSettingsView: View {
    @AppStorage("selectedCalendar") private var selectedCalendar = IslamicCalendar.islamic.rawValue
    @AppStorage("hideDockIcon") private var hideDockIcon = false
    @AppStorage("showHijriDate") private var showHijriDate = true
    @AppStorage("dayOffset") private var dayOffset = 0
    
    var body: some View {
        Form {
            Section {
                Picker("Calendar", selection: $selectedCalendar) {
                    ForEach(IslamicCalendar.allCases, id: \.self) { calendar in
                        Text(calendar.rawValue).tag(calendar.rawValue)
                    }
                }
                .pickerStyle(.menu)
                Toggle("Show Hijri date", isOn: $showHijriDate)
                Stepper("Day offset: \(dayOffset)", value: $dayOffset, in: -5...5)
                Toggle("Hide dock icon", isOn: $hideDockIcon)
                    .onChange(of: hideDockIcon) { value in
                        NSApplication.shared.setActivationPolicy(value ? .accessory : .regular)
                    }
            }
        }
        .formStyle(.grouped)
    }
}


struct AboutSettingsView: View {
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ramadan")
                .font(.title.bold())
            
            Text("Version \(appVersion)")
                .foregroundStyle(.secondary)
            
            Text("A simple menubar app to track Ramadan dates")
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(alignment: .center)
        .padding()
    }
}
