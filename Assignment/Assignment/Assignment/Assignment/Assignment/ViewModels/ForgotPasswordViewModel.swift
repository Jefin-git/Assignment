//
//  ForgotPasswordViewModel.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation
import CoreData

protocol ForgotPasswordViewable {
    func changePassword(username: String, password: String) -> Bool
}

class ForgotPasswordViewModel: ForgotPasswordViewable {
    
    private var passwordChangeSuccess: Bool = false
    
    func changePassword(username: String, password: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try PersistanceService.context.fetch(fetchRequest)
            _ = users.map({ user in
                if user.username == username {
                    passwordChangeSuccess = true
                    _ = PersistanceService.saveContext()
                }
            })
            return passwordChangeSuccess
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}
