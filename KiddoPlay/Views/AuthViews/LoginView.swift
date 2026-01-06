//
//  LoginView.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 29/12/2025.
//

import SwiftUI

struct LoginView: View{
    @State private var viewModel = LoginViewModel()

    var body: some View{
        VStack (alignment: .center){
            VStack(spacing: 20) {
                CustomTextField(iconName: "envelope.fill",
                                placeholder: "Email",
                                text: $viewModel.email,
                                keyboard: .emailAddress,
                                errorMessage: viewModel.emailError
                )

                CustomTextField(iconName: "lock.fill",
                                placeholder: "Password",
                                text: $viewModel.password,
                                isSecure: true,
                                errorMessage: viewModel.passwordError
                )
                if let generalError = viewModel.generalError {
                    Text(generalError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }

            }
            HStack {
                Spacer()
                Button("Forget password ?") {
                    //MARK: forget password action
                }
                .foregroundStyle(Color("BaseColor"))
                .padding(.horizontal,10)
            }
            PrimaryButton(title: "Login",
                          isEnable: viewModel.isFormValid,
                          isLoading: viewModel.isLoading,
                          action: {
                // MARK: SignUp Action
                Task{
                    await viewModel.login()
                }
            })

            .padding(.horizontal,60)
//                .padding(.vertical,10)
            .navigationDestination(isPresented: $viewModel.didLogin) {
                HomeView()
            }
            SocialLoginView()


        }.padding(50)
        .background(Image("loginBg")
            .resizable()
            .scaledToFill()
            .offset(x: -12))
    }
}
struct SocialLoginView: View{
    var body: some View{
        HStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.base.opacity(0.4))

            Text("OR")
                .font(.subheadline)
                .foregroundColor(.base)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(.base.opacity(0.4))
        }
        .padding(.horizontal)

        HStack(spacing: 20) {
            Button(action: {
                // MARK: Facebook Action
            }) {
                Image("facebook")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(12)

            }

            Button(action: {
                // MARK: Facebook Action
            }) {
                Image("google")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(12)

            }

        }

    }
}

#Preview {
    LoginView()
}
