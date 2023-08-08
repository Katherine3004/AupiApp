//
//  User.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/19.
//

import Foundation

struct User: Identifiable, Codable {
    
    let id: String
    let firstname: String
    let lastname: String
    let email: String
    let isAupair: Bool
    let dob: Date?
    let gender: String?
    let location: String?
    
//    let profilePicture:
//    let cv:
    
    
    init(id: String,
         firstname: String,
         lastname: String,
         email: String,
         isAupair: Bool,
         dob: Date? = nil,
         gender: String? = nil,
         location: String? = nil
    ) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.isAupair = isAupair
        self.dob = dob
        self.gender = gender
        self.location = location
    }
    
    var initials: String {
        return "\(firstname.first)\(lastname.first)"
    }
    
    
}
