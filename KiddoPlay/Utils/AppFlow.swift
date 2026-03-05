// AppFlow.swift
import SwiftUI
import Combine


enum AppFlowState {
    case welcome
    case guest
    case loggedIn
}

class AppState: ObservableObject {
    @Published var flow: AppFlowState = .welcome

    init() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            flow = .loggedIn
        } else if UserDefaults.standard.bool(forKey: "isGuest") {
            flow = .guest
        } else {
            flow = .welcome
        }
    }

    func login() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "isGuest")
        flow = .loggedIn
    }

    func continueAsGuest() {
        UserDefaults.standard.set(true, forKey: "isGuest")
        flow = .guest
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "isGuest")
        flow = .welcome
    }
}
