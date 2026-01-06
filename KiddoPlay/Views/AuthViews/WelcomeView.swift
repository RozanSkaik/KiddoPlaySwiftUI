//
//  ContentView.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 06/12/2025.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var appState: AppState

    private enum Destination: Hashable {
        case auth
    }

    @State private var selectedTag = 0
    @State private var destination: Destination?

    var body: some View {
        NavigationStack {
            ZStack {
                Image("SplashBackground")
                    .resizable()
                    .ignoresSafeArea()
                VStack (spacing: 12){
                    Spacer()
                    // MARK: Logo + Title
                    LogoTitleView()

                    // MARK: Guest SignUp Buttons
                    GuestSignUpButtons(
                        onGuest: {
                            // Replace root with HomeView
                            appState.continueAsGuest()
                        },
                        onSignUp: {
                            selectedTag = 1
                            destination = .auth
                        }
                    )

                    // MARK: Have Account View
                    HaveAccountView(onLogin: {
                        selectedTag = 0
                        destination = .auth
                    })
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom, 60)
            }
            .navigationDestination(item: $destination) { dest in
                switch dest {
                case .auth:
                    AuthView(selectedTag: $selectedTag)
                }
            }
        }
    }
}

struct LogoTitleView: View{
    var body: some View{
        VStack { //Logo with title
            Image("AppIcons")
                .frame(height:100)

            Text("Hey champ! Ready to learn and win stars ?")
                .font(.system(size: 42,weight: .heavy, design: .rounded))
                .foregroundStyle(Color("BaseColor"))
                .frame(width: 320)
                .multilineTextAlignment(.center)
        }

    }
}

struct GuestSignUpButtons: View {
    var onGuest: () -> Void
    var onSignUp: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            PrimaryButton(title: "Go as guest") {
                onGuest()
            }
            PrimaryButton(title: "Sign Up") {
                onSignUp()
            }
        }
        .padding(.horizontal, 100)
    }
}

struct HaveAccountView: View{
    var onLogin: () -> Void

    var body: some View{
        HStack{
            Text("have an account?")
            Button("login"){
                onLogin()
            }
            .foregroundStyle(Color("BaseColor"))
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AppState())
}

