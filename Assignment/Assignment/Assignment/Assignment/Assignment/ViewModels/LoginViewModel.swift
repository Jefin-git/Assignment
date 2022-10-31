//
//  LoginViewModel.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation
import CoreData

protocol LoginViewable {
    func loginUser(email: String, password: String) -> Bool
}

class LoginViewModel: LoginViewable {
    
    private var loginSuccess: Bool = false
    
    func loginUser(email: String, password: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try PersistanceService.context.fetch(fetchRequest)
            _ = users.map({ user in
                if user.email == email && user.password == password {
                    loginSuccess = true
                }
            })
            return loginSuccess
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}
