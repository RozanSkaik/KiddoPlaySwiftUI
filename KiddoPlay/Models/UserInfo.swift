//
//  User.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 29/12/2025.
//
import FirebaseAuth

struct UserInfo{
    let uid: String?
    let email: String?
    let displayName: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.displayName = user.displayName
    }
}
