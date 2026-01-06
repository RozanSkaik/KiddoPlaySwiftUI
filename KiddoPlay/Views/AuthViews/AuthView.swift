//
//  LoginView.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 07/12/2025.
//

import SwiftUI

struct AuthView: View {
    @Binding var selectedTag: Int
    var body: some View {
        ZStack {
            Image("AuthBg")
                .resizable()
                .ignoresSafeArea()
            VStack (spacing: 30){
                Spacer()
                Image("AppIcons")
                    .frame(height:100)

                CustomSegmentView(selectedTag: $selectedTag).frame(width: 290)
                Group {
                    if selectedTag == 0 {
                        LoginView()
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                    } else if selectedTag == 1 {
                        SignUpView()
                            .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                }.animation(.easeInOut, value: selectedTag)
            }
        }
    }
}


#Preview {
    struct PreviewHost: View {
        @State private var tag = 0
        var body: some View {
            AuthView(selectedTag: $tag)
        }
    }
    return PreviewHost()
}
