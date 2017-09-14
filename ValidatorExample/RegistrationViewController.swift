//
//  RegistrationViewController.swift
//  bahisadam
//
//  Created by Julius on 11.09.17.
//  Copyright © 2017 ilkerozcan. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class RegistrationViewController: UITableViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!

    
    class func viewController() -> RegistrationViewController{
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        return storyboard.instantiateInitialViewController() as! RegistrationViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    @IBAction func registerationAction(_ sender: Any) {
        
        let user = User.init(login: loginTextField.text,
                             password: passwordTextField.text,
                             confirmPassword: passwordConfirmTextField.text,
                             email: emailTextField.text)
        
        if user.isValid() {
            self.register(withUser: user)
        }
        
    }
    
    private func register(withUser user: User){
        
    }
    
    private func setupUI() {
        for tf in [loginTextField,emailTextField,passwordConfirmTextField,passwordTextField]{
            tf?.layer.borderWidth = 3.0
            tf?.layer.borderColor = UIColor.clear.cgColor
        }
    }
}


struct User {
    var login: String?
    var password: String?
    var confirmPassword: String?
    var email: String?
}

extension User{
    func isValid() -> Bool{
        guard TextValidator(forRule: .login).isValid(text: login) else {
            return false
        }
        
        guard TextValidator(forRule: .email).isValid(text: email) else {
            return false
        }
        
        guard TextValidator(forRule: .password).isValid(text: password),
              password == confirmPassword  else {
                
            return false
        }
        
        return true
    }
}

