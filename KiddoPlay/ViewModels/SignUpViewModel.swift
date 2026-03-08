//
//  SignUpViewModel.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 29/12/2025.
//

import SwiftUI

@MainActor
@Observable
final class SignUpViewModel {

    private let service: AuthService

    init(service: AuthService = AuthenticationManager.shared) {
        self.service = service
    }

    var name = ""
    var email = ""
    var password = ""
    var confirmPassword = ""

    var nameError: String?
    var emailError: String?
    var passwordError: String?
    var confirmPasswordError: String?

    var isLoading = false
    var generalError: String?

    var isFormValid: Bool {
        !name.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty
    }

    var didSignUp: Bool = false

    func signUp() async {
        clearErrors()

        let validation = Validator.SignUp.validate(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword
        )

        nameError = validation.nameError
        emailError = validation.emailError
        passwordError = validation.passwordError
        confirmPasswordError = validation.confirmPasswordError

        guard validation.isValid else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            _ = try await service.createUserAccount(
                withEmail: email,
                password: password,
                name: name
            )
            didSignUp = true
        } catch {
            generalError = error.localizedDescription
        }
    }

    private func clearErrors() {
        nameError = nil
        emailError = nil
        passwordError = nil
        confirmPasswordError = nil
        generalError = nil
    }

}
