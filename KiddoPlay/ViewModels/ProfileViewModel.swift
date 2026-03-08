//
//  ProfileViewModel.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 09/03/2026.
//

import SwiftUI

@MainActor
@Observable
final class ProfileViewModel {
    private let service: AuthService

    init(service: AuthService = AuthenticationManager.shared) {
        self.service = service
    }

    var user: UserInfo?
    var didLogout: Bool = false

    func load() async {
        user = AuthenticationManager.shared.getLoggedInUser()
    }

    func logout() {
        didLogout = true
    }
}
