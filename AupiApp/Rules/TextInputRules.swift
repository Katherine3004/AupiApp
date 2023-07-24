//
//  TextInputRules.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/24.
//

import Foundation

struct ValidationRules {
    
    static let firstNameRules: [((String) -> Bool, String)] = [
        ({ !$0.isEmpty }, "First name is a required field"),
        ({ $0.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil }, "First name cannot contain special characters or numbers"),
        ({ $0.count >= 1 }, "First name requires at least one character")
    ]
    
    static let lastNameRules: [((String) -> Bool, String)] = [
        ({ !$0.isEmpty }, "Last name is a required field"),
        ({ $0.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil }, "Last name cannot contain special characters or numbers"),
        ({ $0.count >= 1 }, "Last name requires at least one character")
    ]
    
    static let emailRules: [((String) -> Bool, String)] = [
        ({ !$0.isEmpty }, "Email address is a required field"),
        ({ $0.contains("@") && $0.contains(".") }, "Invalid email address")
    ]
    
    static let passwordRules: [((String) -> Bool, String)] = [
        ({ $0.count >= 6 }, "Password must be at least 6 characters long"),
        ({ $0.containsSpecialCharacter }, "Password must contain a special character"),
        ({ $0.containsUppercaseLetter }, "Password must contain a capital letter"),
        ({ $0.containsNumber }, "Password must contain a number")
    ]
}
