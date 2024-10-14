//
//  SignUpViewModel.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/13/24.
//

import FirebaseAuth

class SignUpViewModel {
    func createUser(email: String, password: String) async throws -> AuthDataResult {
        try await FirestoreService.shared.createUser(email: email, password: password)
    }
}
