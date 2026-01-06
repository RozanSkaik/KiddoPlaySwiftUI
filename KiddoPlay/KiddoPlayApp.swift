//
//  KiddoPlayApp.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 06/12/2025.
//

import SwiftUI
import Firebase
@main
struct KiddoPlayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject private var appState = AppState()
    var body: some Scene {
        WindowGroup {
            switch appState.flow {
            case .welcome:
                WelcomeView()
                    .environmentObject(appState)
            case .guest:
                HomeView()
                    .environmentObject(appState)

            case .loggedIn:
                HomeView()
                    .environmentObject(appState)
            }
        }
    }
}
