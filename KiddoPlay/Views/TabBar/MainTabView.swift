//
//  MainTabView.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 22/01/2026.
//

import SwiftUI

enum TabItem: Int, CaseIterable {
    case home, trophie, profile

    var selectedIcon: String {
        switch self {
        case .home: return "selectedHome"
        case .trophie: return "selectedTrophie"
        case .profile: return "selectedProfile"
        }
    }

    var unselectedIcon: String {
        switch self {
        case .home: return "home"
        case .trophie: return "trophie"
        case .profile: return "profile"
        }
    }
}

@ViewBuilder
func tabIcon(for tab: TabItem, selectedTab: TabItem) -> some View {
    Image(tab == selectedTab ? tab.selectedIcon : tab.unselectedIcon)
        .renderingMode(.original)
}


struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab: TabItem = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                tabView(for: tab)
                    .tabItem {
                        tabIcon(for: tab, selectedTab: selectedTab)
                    }
                    .tag(tab)
            }
        }
    }

    @ViewBuilder
    private func tabView(for tab: TabItem) -> some View {
        switch tab {
        case .home: HomeView()
        case .trophie: TrophieView()
        case .profile: ProfileView()
        }
    }
}


#Preview {
    MainTabView()
        .environmentObject(AppState())
}
