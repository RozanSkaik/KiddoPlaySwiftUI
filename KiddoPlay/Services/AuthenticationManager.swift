//
//  AuthenticationManager.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 29/12/2025.
//
import FirebaseAuth
import Foundation

class AuthenticationManager{
    static let shared = AuthenticationManager()

    private init () {}

    func getLoggedInUser()-> UserInfo?{
        guard let user = Auth.auth().currentUser else{ return nil}
        return UserInfo(user: user)
    }
    func createUserAccount(withEmail email: String, password: String, name: String) async throws -> UserInfo{
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let changeResult = authResult.user.createProfileChangeRequest()
        changeResult.displayName = name
        try await changeResult.commitChanges()
        return UserInfo(user: authResult.user)
    }
    func loginWithEmail(email: String, password: String) async throws -> UserInfo{
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return UserInfo(user: authResult.user)
    }
}
