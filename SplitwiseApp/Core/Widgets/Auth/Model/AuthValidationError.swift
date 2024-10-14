//
//  AuthValidationError.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/13/24.
//

import Foundation

enum AuthValidationError: LocalizedError {
    case emailValidationError(EmailValidationError)
    case passwordError(PasswordValidationError)
    
    var errorDescription: String? {
        switch self {
        case .emailValidationError(let error):
            error.errorDescription
        case .passwordError(let error):
            error.errorDescription
        }
    }
}

enum EmailValidationError: LocalizedError {
    case empty
    case invalidFormat

    var errorDescription: String? {
        switch self {
        case .empty:
            return "Email cannot be empty."
        case .invalidFormat:
            return "Email format is invalid."
        }
    }
}

enum PasswordValidationError: LocalizedError {
    case empty
    case tooShort(minLength: Int)
    case missingUppercase
    case missingLowercase
    case missingDigit
    case missingSpecialCharacter
    case commonPassword // TODO: Use API to ensure password does not contain a common English word
    case mismatch
    
    var errorDescription: String? {
        switch self {
        case .empty:
            return "Password cannot be empty."
        case .tooShort(let minLength):
            return "Password must be at least \(minLength) characters long."
        case .missingUppercase:
            return "Password must contain at least one uppercase letter."
        case .missingLowercase:
            return "Password must contain at least one lowercase letter."
        case .missingDigit:
            return "Password must contain at least one digit."
        case .missingSpecialCharacter:
            return "Password must contain at least one special character."
        case .commonPassword:
            return "Password is too common. Please choose a stronger password."
        case .mismatch:
            return "Passwords do not match."
        }
    }
}
