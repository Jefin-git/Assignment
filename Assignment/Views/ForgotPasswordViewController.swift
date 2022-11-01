//
//  ForgotPasswordViewController.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let validation: ValidationService
    let forgotPasswordViewModel: ForgotPasswordViewable
    
    init(validation: ValidationService,
         forgotPasswordViewModel: ForgotPasswordViewable) {
        self.validation = validation
        self.forgotPasswordViewModel = forgotPasswordViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.validation = ValidationService()
        self.forgotPasswordViewModel = ForgotPasswordViewModel()
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        do {
        let username = try validation.validateUsername(usernameTextField.text)
        let password = try validation.validatePassword(passwordTextField.text)
        let confirmPassword = try validation.validatePassword(confirmPasswordTextField.text)
        if try validation.validatePasswords(password: password, confirmPassword: confirmPassword) {
            
            if forgotPasswordViewModel.changePassword(username: username, password: password) {
                self.showAlertController(title: "Success", message: "Password has been changed successfully")
            } else {
                self.showAlertController(title: "Error", message: "Please enter valid credentials")
            }
        }
        } catch(let error) {
            showAlertController(title: "Error", message: error.localizedDescription)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
