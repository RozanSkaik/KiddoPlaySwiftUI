//
//  HomeView.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 09/12/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Image("HomeBg")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    List {
                        Image("Welcome")
                            .resizable()
                            .scaledToFill()
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        ForEach(viewModel.items) { item in
                            HomeListItemView(item: item)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                                .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                    .ignoresSafeArea(edges: .top)
                }
                .padding(.horizontal,30)
                .padding(.vertical,5)

            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                AppNavigationToolbar(
                    score: 12,
                    onMenuTap: {
                        print("Open menu")
                    }
                )
            }
        }
    }
}

#Preview {
    HomeView()
}

