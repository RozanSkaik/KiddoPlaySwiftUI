//
//  SignUpView.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 29/12/2025.
//

import SwiftUI

struct SignUpView: View {
    @State var viewModel = SignUpViewModel()

    var body: some View{
        VStack(alignment: .center){
            VStack(spacing: 14) {
                CustomTextField(iconName: "person.fill", placeholder: "Username", text: $viewModel.name, errorMessage: viewModel.nameError)

                CustomTextField(iconName: "envelope.fill", placeholder: "Email", text: $viewModel.email, keyboard: .emailAddress,errorMessage: viewModel.emailError)

                CustomTextField(iconName: "lock.fill", placeholder: "Password", text: $viewModel.password,isSecure: true,errorMessage: viewModel.passwordError)

                CustomTextField(iconName: "lock.fill", placeholder: "Confirm Password", text: $viewModel.confirmPassword,isSecure: true, errorMessage: viewModel.confirmPasswordError)

                // General backend error
                    if let generalError = viewModel.generalError {
                        Text(generalError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                PrimaryButton(title: "Sign Up",
                              isEnable: viewModel.isFormValid,
                              isLoading: viewModel.isLoading,
                              action: {
                    // MARK: SignUp Action
                    Task{
                        await viewModel.signUp()
                    }
                })

                .padding(.horizontal,60)
//                .padding(.vertical,10)
                .navigationDestination(isPresented: $viewModel.didSignUp) {
                    HomeView()
                }
            }
        }.padding(50)
            .background(Image("loginBg")
                .resizable()
                .scaledToFill()
                .clipped()
                .offset(x: -12)
            )

    }
}

#Preview {
    SignUpView()
}
