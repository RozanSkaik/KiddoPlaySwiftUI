//
//  CustomTextField.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 08/12/2025.
//

import SwiftUI

struct CustomTextField: View {
    var iconName: String
    var placeholder: String
    @Binding var text: String
    var borderColor: Color = Color.base
    var cornerRadius: CGFloat = 25
    var padding: CGFloat = 17
    var shadowColor: Color = .gray.opacity(0.3)
    var shadowRadius: CGFloat = 5
    var shadowX: CGFloat = 0
    var shadowY: CGFloat = 4
    var backgroundColor: Color = Color(.systemBackground)
    var isSecure: Bool = false
    var keyboard: UIKeyboardType = .default
    // Validation
    let errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            HStack {
                Image(systemName: iconName)
                    .foregroundColor(Color.base)

                if isSecure {
                    SecureField(placeholder, text: $text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)

                } else {
                    TextField(placeholder, text: $text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(keyboard)

                }
            }
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(errorMessage == nil ? borderColor : Color.red, lineWidth: 3)
                    )
            )

            // error message
            if let msg = errorMessage {
                Text(msg)
                    .font(.caption)
                    .foregroundColor(.red)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

#Preview {
    struct PreviewHost: View {
        @State private var username = ""

        var body: some View {
            CustomTextField(
                iconName: "person.fill",
                placeholder: "User name",
                text: $username,
                errorMessage: ""
            )
        }
    }
    return PreviewHost()
}
