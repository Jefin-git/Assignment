//
//  SignupViewController.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation
import UIKit

class SignupViewController: UIViewController {
   
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    
    let signUpViewModel: SignupViewable
    let validation: ValidationService
    
    init(signUpViewModel: SignupViewable,
         validation: ValidationService) {
        self.signUpViewModel = signUpViewModel
        self.validation = validation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.signUpViewModel = SignupViewModel()
        self.validation = ValidationService()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        do {
            let username = try validation.validateUsername(usernameTextField.text)
            let email = try validation.validateEmailId(emailTextField.text)
            let password = try validation.validatePassword(passwordTextField.text)
            guard try validation.validatePasswords(password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text) else { throw ValidationError.passwordMissmatch }
            let mobile = try validation.validateMobileNumber(mobileTextField.text)
            if signUpViewModel.registerUser(username: username, email: email, password: password, mobile: mobile) {
                
                DispatchQueue.main.async {
                    self.clearFields()
                    self.showAlertController(title: "Success", message: "The user has been registered successfully")
                }
                
            }
        } catch {
            self.showAlertController(title: "Error", message: error.localizedDescription)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func clearFields() {
        usernameTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        mobileTextField.text = ""
        emailTextField.text = ""
    }
}
