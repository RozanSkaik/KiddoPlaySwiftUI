//
//  CustomDialog.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 27/02/2026.
//

import SwiftUI

struct CustomDialog<Content: View>: View {
    let content: Content
    let onDismiss: () -> Void

    @State private var animate = false

    init(onDismiss: @escaping () -> Void,
         @ViewBuilder content: () -> Content) {
        self.content = content()
        self.onDismiss = onDismiss
    }

    var body: some View {
        ZStack {
            // Background
            Image("HomeBg")
                .resizable()
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            // Dialog
            content
                .padding(24)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .shadow(color: .black.opacity(0.25), radius: 30, y: 20)
                .scaleEffect(animate ? 1 : 0.85)
                .opacity(animate ? 1 : 0)
                .offset(y: animate ? 0 : 20)
        }
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                animate = true
            }
        }
    }

    private func dismiss() {
        withAnimation(.easeInOut(duration: 0.2)) {
            animate = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            onDismiss()
        }
    }
}

#Preview {
    CustomDialog(onDismiss: {

    }, content: {
        
    })
}
