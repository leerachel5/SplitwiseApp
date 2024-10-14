//
//  SignUpViewModel.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/13/24.
//

import FirebaseAuth

class SignUpViewModel {
    private let minimumPasswordLength = 6
    
    func signUp(email: String, password: String, confirmationPassword: String) async throws -> User {
        try validateEmailFormat(email)
        try validatePasswordFormat(password, confirmationPassword: confirmationPassword)
        return try await createUser(email: email, password: password)
    }
    
    // MARK: Email Validation
    private func validateEmailFormat(_ email: String) throws {
        if email.isEmpty {
            throw EmailValidationError.empty
        } else if !isValidEmail(email) {
            throw EmailValidationError.invalidFormat
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK: Password Validation
    private func validatePasswordFormat(_ password: String, confirmationPassword: String) throws {
        if password != confirmationPassword {
            throw PasswordValidationError.mismatch
        } else if password.isEmpty {
            throw PasswordValidationError.empty
        } else if password.count < minimumPasswordLength {
            throw PasswordValidationError.tooShort(minLength: minimumPasswordLength)
        } else if !password.contains(where: { $0.isUppercase }) {
            throw PasswordValidationError.missingUppercase
        } else if !password.contains(where: { $0.isLowercase }) {
            throw PasswordValidationError.missingLowercase
        } else if !password.contains(where: { $0.isNumber }) {
            throw PasswordValidationError.missingDigit
        } else if !password.contains(where: { $0.isSymbol || $0.isPunctuation }) {
            throw PasswordValidationError.missingSpecialCharacter
        }
    }
    
    // MARK: Create User
    private func createUser(email: String, password: String) async throws -> User {
        let authDataResult = try await FirestoreService.shared.createUser(email: email, password: password)
        return User(authDataResult.user)
    }
}
