//
//  ValidationService.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation

struct ValidationService {

    //MARK: Methods to validate the credentials
    func validateEmailId(_ email: String?) throws -> String {
        guard let email = email else { throw ValidationError.invalidValue }
        guard email.isValidEmail else { throw ValidationError.invalidEmail }
        return email
    }
    
    func validateUsername(_ username: String?) throws -> String {
        guard let username = username else { throw ValidationError.invalidValue }
        guard !username.isEmpty else { throw ValidationError.missingUsername }
        return username
    }
    
    func validatePassword(_ password: String?) throws -> String {
        guard let password = password else { throw ValidationError.invalidValue }
        guard !password.isEmpty else { throw ValidationError.missingPassword }
        guard password.isStrongPassword else { throw ValidationError.invalidPassword }
        return password
    }
    
    func validateMobileNumber(_ mobile: String?) throws -> String {
        guard let mobile = mobile else { throw ValidationError.invalidValue }
        guard mobile.isValidMobileNumber else { throw ValidationError.invalidMobileNumber }
        return mobile
    }
    
    func validatePasswords(password: String?, confirmPassword: String?) throws -> Bool {
        guard let password = password else { throw ValidationError.invalidValue }
        guard let confirmPassword = confirmPassword else { throw ValidationError.invalidValue }
        if password == confirmPassword { return true }
        return false
    }
}

enum ValidationError: LocalizedError {
    case invalidValue
    case invalidEmail
    case invalidPassword
    case invalidMobileNumber
    case passwordMissmatch
    case missingUsername
    case missingPassword
    
    var errorDescription: String? {
        switch self {
        case .invalidValue:
            return "You have entered an invalid value"
        case .invalidEmail:
            return "You have entered an invalid email"
        case .invalidPassword:
            return "Please enter a invalid password"
        case .invalidMobileNumber:
            return "Please enter a invalid mobile number"
        case .passwordMissmatch:
            return "Entered passwords do not match"
        case .missingUsername:
            return "Please enter a valid username"
        case .missingPassword:
            return "Please enter a valid password"
        }
    }
}
