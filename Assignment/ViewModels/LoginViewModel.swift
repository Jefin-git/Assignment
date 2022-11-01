//
//  LoginViewModel.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation
import CoreData

protocol LoginViewable {
    func loginUser(email: String, password: String) -> (String, Bool)
}

class LoginViewModel: LoginViewable {
    
    private var loginSuccess: (String, Bool) = ("", false)
    
    //MARK: Login using credentials and validating with values in database
    func loginUser(email: String, password: String) -> (String, Bool) {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try PersistanceService.context.fetch(fetchRequest)
            _ = users.map({ user in
                if user.email == email && user.password == password {
                    loginSuccess = (user.username ?? "", true)
                }
            })
            return loginSuccess
        } catch {
            print(error.localizedDescription)
        }
        return loginSuccess
    }
}
