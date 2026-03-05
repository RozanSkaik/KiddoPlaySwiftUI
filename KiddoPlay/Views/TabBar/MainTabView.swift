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
    @State private var showTrophiePopup = false
    @State private var previousTab: TabItem = .home

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ForEach(TabItem.allCases, id: \.self) { tab in
                    tabView(for: tab)
                        .tabItem {
                            tabIcon(for: tab, selectedTab: selectedTab)
                        }
                        .tag(tab)
                }
            }
            .blur(radius: showTrophiePopup ? 6 : 0)
            .animation(.easeInOut(duration: 0.2), value: showTrophiePopup)

            if showTrophiePopup {
                CustomDialog {
                    dismissTrophie()
                } content: {
                    TrophieView()
                }
                .zIndex(1)
            }
        }
        .onChange(of: selectedTab) { _, newValue in
            if newValue == .trophie {
                showTrophiePopup = true
            } else {
                previousTab = newValue
            }
        }
    }

    private func dismissTrophie() {
        showTrophiePopup = false
        selectedTab = previousTab
    }
}


@ViewBuilder
private func tabView(for tab: TabItem) -> some View {
    switch tab {
    case .home: HomeView()
    case .trophie: Color.clear
    case .profile: ProfileView()
    }
}


#Preview {
    MainTabView()
        .environmentObject(AppState())
}
