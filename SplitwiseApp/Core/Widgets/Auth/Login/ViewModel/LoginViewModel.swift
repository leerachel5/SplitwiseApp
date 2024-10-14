//
//  LoginViewModel.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/13/24.
//

import FirebaseAuth

struct LoginViewModel {
    func login(email: String, password: String) async throws -> User {
        let authDataResult = try await FirestoreService.shared.login(email: email, password: password)
        return User(authDataResult.user)
    }
}
