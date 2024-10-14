//
//  User.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 8/31/24.
//

import FirebaseAuth

struct User: Identifiable, Hashable, Codable {
    let id: String
    let email: String?
    
    init(_ firebaseAuthUser: FirebaseAuth.User) {
        self.id = firebaseAuthUser.uid
        self.email = firebaseAuthUser.email
    }
}
