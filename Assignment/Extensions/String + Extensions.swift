//
//  String + Extensions.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    var isStrongPassword: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{6,12}").evaluate(with: self)
    }
    
    var isValidMobileNumber: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^[6-9]\\d{9}$").evaluate(with: self)
    }
}
