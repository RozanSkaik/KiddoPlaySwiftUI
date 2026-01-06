//
//  Validator.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 03/01/2026.
//

import Foundation

struct SignUpValidationResult {
    let nameError: String?
    let emailError: String?
    let passwordError: String?
    let confirmPasswordError: String?

    var isValid: Bool {
        [nameError, emailError, passwordError, confirmPasswordError].allSatisfy { $0 == nil }
    }
}

struct LoginValidationResult {
    let emailError: String?
    let passwordError: String?

    var isValid: Bool {
        [emailError, passwordError].allSatisfy { $0 == nil }
    }
}
enum Validator {

    enum Auth {
        static func email(_ value: String) -> String? {
            value.isValidEmail ? nil : "Invalid email"
        }

        static func password(_ value: String) -> String? {
            value.count >= 8 ? nil : "Password must be at least 8 characters"
        }
    }

    enum SignUp {
        static func validate(
            name: String,
            email: String,
            password: String,
            confirmPassword: String
        ) -> SignUpValidationResult {

            SignUpValidationResult(
                nameError: name.trimmingCharacters(in: .whitespaces).isEmpty ? "Name is required" : nil,
                emailError: Auth.email(email),
                passwordError: Auth.password(password),
                confirmPasswordError: password != confirmPassword ? "Passwords do not match" : nil
            )
        }
    }

    enum Login {
        static func validate(
            email: String,
            password: String,
        ) -> LoginValidationResult {

            LoginValidationResult(
                emailError: Auth.email(email),
                passwordError: Auth.password(password),
            )
        }
    }
}

extension String {
    var isValidEmail: Bool {
        NSPredicate(
            format: "SELF MATCHES %@",
            "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        ).evaluate(with: self)
    }
}
