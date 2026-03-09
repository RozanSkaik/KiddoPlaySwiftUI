//
//  ProfileView.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 08/02/2026.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @State private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Image("HomeBg")
                    .resizable()
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .foregroundStyle(.white)

                    if let user = viewModel.user {
                        VStack(spacing: 6) {
                            Text(user.displayName ?? "Champion")
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundStyle(.base)

                            Text(user.email ?? "")
                                .font(.subheadline)
                                .foregroundStyle(.base.opacity(0.8))
                        }
                    }

                    PrimaryButton(title: "LogOut") {
                        viewModel.logout()
                    }
                    .padding(.horizontal, 80)
                    .padding(.top, 16)
                }
                .padding(.top, 40)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                AppNavigationToolbar(
                    score: 0,
                    onMenuTap: {}
                )
            }
        }
        .task {
            await viewModel.load()
        }
        .onChange(of: viewModel.didLogout) { _, didLogout in
            if didLogout { appState.logout() }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
}
