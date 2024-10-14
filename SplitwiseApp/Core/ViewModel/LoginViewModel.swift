//
//  LoginViewModel.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/13/24.
//

import FirebaseAuth

struct LoginViewModel {
    func login(email: String, password: String) async throws -> AuthDataResult {
        try await FirestoreService.shared.login(email: email, password: password)
    }
}
