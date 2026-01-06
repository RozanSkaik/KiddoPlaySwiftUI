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

    var name = ""
    var email = ""
    var password = ""
    var confirmPassword = ""

    // Field-level errors
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

    // track success
    var didSignUp: Bool = false

    func signUp() async {
        clearErrors()

        // Call validator
        let validation = Validator.SignUp.validate(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword
        )

        // Assign named errors
        nameError = validation.nameError
        emailError = validation.emailError
        passwordError = validation.passwordError
        confirmPasswordError = validation.confirmPasswordError

        // Stop if invalid
        guard validation.isValid else { return }

        // Proceed with API
        isLoading = true
        defer { isLoading = false } // Hide loader after excute all operations

        do {
            _ = try await AuthenticationManager.shared
                .createUserAccount(
                    withEmail: email,
                    password: password,
                    name: name
                )
            // ✅ Mark as success
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
