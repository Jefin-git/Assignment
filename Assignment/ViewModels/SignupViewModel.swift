//
//  SignupViewModel.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation

protocol SignupViewable {
    func registerUser(username: String, email: String, password: String, mobile: String) -> Bool
}

class SignupViewModel: SignupViewable {
 
    //MARK: Registering user and saving to database
    func registerUser(username: String, email: String, password: String, mobile: String) -> Bool {
        
        let context = PersistanceService.context
        let user = User(context: context)
        user.username = username
        user.email = email
        user.password = password
        user.mobile = mobile
        
        if PersistanceService.saveContext() {
        return true
        }
        return false
    }
}
