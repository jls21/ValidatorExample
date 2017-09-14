//
//  ValidationTextField.swift
//  bahisadam
//
//  Created by Julius on 11.09.17.
//  Copyright © 2017 ilkerozcan. All rights reserved.
//

import Foundation
import UIKit

enum State{
    case valid, invalid, initial
}

protocol ValidationControl {
    
    var validState : State {get set}
    
    var validator : TextValidator {get set}
    
    var hintLabel: UILabel? {get set}
    
    func validate()
}

class ValidtaionTextField: UITextField, ValidationControl{
    
    var validator : TextValidator = TextValidator(forRule:.none)
    
    var validState : State = .initial
    
    @IBOutlet weak var hintLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addTarget(self, action: #selector(validate), for: .editingChanged)
    }
    
    func validate() {
        
        let isValid = self.validator.isValid(text: self.text)
        
        if isValid == true {
            self.configure(forState: .valid, hintText: "")
        }else{
            self.configure(forState: .invalid, hintText: validator.rule.hint())
        }
    }
    
    func configure(forState state: State, hintText: String){
        
        self.validState = state
        
        var borderColor: CGColor!
        
        switch state {
        case .valid:
            
            borderColor = UIColor.green.cgColor
            
            break
        case .invalid:
            
            borderColor = UIColor.red.cgColor
            
            break
        
        default:
            break
        }
        
        self.layer.borderColor = borderColor
        self.hintLabel?.text = hintText
    }
    
}

class LoginTextField: ValidtaionTextField{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.validator = TextValidator(forRule: .login)
    }
}

class EmailTextField: ValidtaionTextField{
    override func awakeFromNib() {
        super.awakeFromNib()
        
         self.validator = TextValidator(forRule: .email)
    }
}

class PasswordTextField: ValidtaionTextField{
    
    @IBOutlet weak var secondPasswordTextField: ValidtaionTextField?
    
    override func validate() {
        super.validate()
        
        if self.validState == .valid && self.secondPasswordTextField?.validState == .valid{
           
            if self.text != self.secondPasswordTextField?.text{
                
                self.configure(forState: .invalid, hintText: "Password missmatched")
            }
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
         self.validator = TextValidator(forRule: .password)
    }
}


