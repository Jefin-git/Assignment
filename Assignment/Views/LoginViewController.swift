//
//  LoginViewController.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let validation: ValidationService
    let loginViewModel: LoginViewable
    var items = [Items]()
    init(validation: ValidationService,
         loginViewModel: LoginViewable) {
        self.validation = validation
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.validation = ValidationService()
        self.loginViewModel = LoginViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }

    @IBAction func forgotPasswordClicked(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let controller = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        do {
         let email = try validation.validateEmailId(emailTextField.text)
         let password = try validation.validatePassword(passwordTextField.text)
        
         let loginCall = loginViewModel.loginUser(email: email, password: password)
         if loginCall.1 {
             let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
             guard let controller = storyBoard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else { return }
             controller.username = loginCall.0
             navigationController?.pushViewController(controller, animated: true)
             
         } else {
             
         self.showAlertController(title: "Error", message: "Please enter valid credentials")
         }
        } catch(let error) {
            showAlertController(title: "Error", message: error.localizedDescription)
        }
    }
    
    @IBAction func signupButtonClicked(_ sender: Any)  {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let controller = storyBoard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
}

