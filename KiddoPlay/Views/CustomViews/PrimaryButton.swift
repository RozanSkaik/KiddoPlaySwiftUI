//
//  PrimaryButton.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 07/12/2025.
//

import SwiftUI
struct PrimaryButton: View{
    var title: String
    var isEnable: Bool = true
    var isLoading: Bool = false
    var action: () -> Void

    var body: some View{
        if isLoading {
            ZStack {
                // Circle background
                Circle()
                    .fill(Color("SecondaryColor"))
                    .frame(width: 60, height: 60)

                // Loader
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
        } else {
            Button(action: action) {
                Text(title)
                    .font(.system(size: 21, weight: .heavy, design: .rounded))
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(isEnable ? Color("SecondaryColor") : Color("SecondaryColor").opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }.disabled(!isEnable)
        }
    }


}
