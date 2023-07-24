//
//  String+Extentions.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/24.
//

import Foundation

extension String {
    var containsSpecialCharacter: Bool {
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?")
        return self.rangeOfCharacter(from: specialCharacterSet) != nil
    }
    
    var containsUppercaseLetter: Bool {
        return self != self.lowercased()
    }
    
    var containsNumber: Bool {
        return self.rangeOfCharacter(from: .decimalDigits) != nil
    }
}
