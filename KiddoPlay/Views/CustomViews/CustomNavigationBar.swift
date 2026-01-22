//
//  CustomNavigationBar.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 22/01/2026.
//

import SwiftUI

struct AppNavigationToolbar: ToolbarContent {
    let score: Int
    let onMenuTap: () -> Void

    var body: some ToolbarContent {
        // Left: menu
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: onMenuTap) {
                Image(systemName: "line.horizontal.3")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .glassEffect(.regular.tint(.base.opacity(0.3)))

        }

        // Center: logo
        ToolbarItem(placement: .principal) {
            Image("AppIcons")
                .resizable()
                .scaledToFit()
                .frame(height: 125)
        }

        // Right: score
        ToolbarItem(placement: .navigationBarTrailing) {
            ZStack{
                Image("star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 65)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                Text("\(score)")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }.sharedBackgroundVisibility(.hidden)
    }
}
