//
//  HomeView.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 09/12/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            Text("Hello, World!")
            Button("Logout") {
                appState.logout()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}

