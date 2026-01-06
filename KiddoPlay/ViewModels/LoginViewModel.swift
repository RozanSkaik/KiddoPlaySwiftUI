//
//  LoginViewModel.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 03/01/2026.
//

import SwiftUI

@MainActor
@Observable
final class LoginViewModel{
    var email = ""
    var password = ""

    var emailError: String?
    var passwordError: String?

    var isLoading = false
    var generalError: String?
    
    var isFormValid: Bool {
        !email.isEmpty &&
        !password.isEmpty
    }

    // track success
    var didLogin: Bool = false

    func login() async{
        clearErrors()

        let validation = Validator.Login.validate(
            email: email,
            password: password)

        emailError = validation.emailError
        passwordError = validation.passwordError

        guard validation.isValid else { return }

        isLoading = true

        defer { isLoading = false }

        do {
            _ = try await AuthenticationManager.shared
                .loginWithEmail(
                    email: email,
                    password: password
                )
            // ✅ Mark as success
            didLogin = true
        } catch {
            generalError = error.localizedDescription
        }
    }

    private func clearErrors() {
        emailError = nil
        passwordError = nil
        generalError = nil
    }
}
