//
//  TextValidator.swift
//  bahisadam
//
//  Created by Julius on 11.09.17.
//  Copyright © 2017 ilkerozcan. All rights reserved.
//

import Foundation

struct TextValidator{
    
    var rule : ValidationRules = .none
    
    init(forRule rule: ValidationRules){
        self.rule = rule
    }
    
    func isValid(text: String?) -> Bool {
        
        guard text != nil, self.isPassedCommonRule(withText:text!) else {
            return false
        }
        
        let predicateForRule = NSPredicate(format:"SELF MATCHES %@", self.rule.regularExpression())
        
        return predicateForRule.evaluate(with: text!)
    }
    
    func isPassedCommonRule(withText text:String) -> Bool {
        return text.characters.count > 0
    }
    
}

enum ValidationRules {
    case login ,email, password, none
    
    func regularExpression() -> String {
        
        switch self {
        case .login, .password:
            return "^[a-zA-Z0-9]{3,12}$"
            
        case .email:
            return "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        default:
            return ""
        }
        
        
    }
    
    func hint() -> String{
        switch self {
        case .login, .password:
            return "Lengh must be in range from 3 to 12 characters"
            
        case .email:
            return "Email must be in format xxxxx@xxxx.xx"
        default:
            return ""
        }
        
    }
}
