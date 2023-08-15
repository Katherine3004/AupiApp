//
//  AuthenticationViewModel.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/19.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import UIKit
import FirebaseStorage

protocol AuthFormProtocol {
    var formIsValid: Bool { get }
}

enum SignInState {
    case signedIn
    case signedOut
}

@MainActor
class AuthenticationViewModel: ObservableObject {
    
    @Published private(set) var signInState: SignInState? = .signedOut
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var allUsers: [User] = []
    
    @Published var errorDescription: String = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            try await fetchUser()
            try await fetchAllUsers()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await fetchUser()
            signInState = .signedIn
        }
        catch {
            errorDescription = "\(error.localizedDescription)"
            print("DEBUG: Failed to sign in user with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, firstname: String, lastname: String, isAupair: Bool) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, firstname: firstname, lastname: lastname, email: email, isAupair: isAupair)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("user").document(user.id).setData(encodedUser)
            
            try await fetchUser()
            signInState = .signedIn
        }
        catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            signInState = .signedOut
        }
        catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let snapshot = try await Firestore.firestore().collection("user").document(uid).getDocument()
            self.currentUser = try snapshot.data(as: User.self)
            
            print("DEBUG: User is: \(self.currentUser)")
        }
        catch {
            print("DEBUG: Failed to retreive user data \(error.localizedDescription)")
        }
    }
    
    func fetchAllUsers() async throws {
        do {
            let querySnapshot = try await Firestore.firestore().collection("user").getDocuments()
            let users = querySnapshot.documents.compactMap { document in
                try? document.data(as: User.self)
            }
            allUsers = users
        }
        catch {
            print("DEBUG: Failed to retrieve all users: \(error.localizedDescription)")
        }
    }
    
    func updateProfile(profileImage: UIImage? = nil, cvData: Data? = nil, bio: String? = nil) async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else {
                print("DEBUG: No authenticated user found")
                return
            }
            
            if let profileImage = profileImage {
                let storageRef = Storage.storage().reference().child("profileImages/\(uid).jpg")
                if let imageData = profileImage.jpegData(compressionQuality: 0.5) {
                    _ = storageRef.putData(imageData, metadata: nil) { metadata, error in
                        if let error = error {
                            print("DEBUG: Error uploading profile image: \(error.localizedDescription)")
                        }
                        else {
                            storageRef.downloadURL { url, error in
                                if let downloadURL = url {
                                    Firestore.firestore().collection("user").document(uid).updateData(["profileImageURL": downloadURL.absoluteString])
                                }
                                else if let error = error {
                                    print("DEBUG: Error getting profile image URL: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }
            }
            
            if let cvData = cvData {
                let storageRef = Storage.storage().reference().child("cvFiles/\(uid).pdf")
                _ = storageRef.putData(cvData, metadata: nil) { metadata, error in
                    if let error = error {
                        print("DEBUG: Error uploading CV: \(error.localizedDescription)")
                    }
                    else {
                        storageRef.downloadURL { url, error in
                            if let downloadURL = url {
                                Firestore.firestore().collection("user").document(uid).updateData(["cvURL": downloadURL.absoluteString])
                            } else if let error = error {
                                print("DEBUG: Error getting CV URL: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
            
            //Update user
            try await Firestore.firestore().collection("user").document(uid).updateData(["bio": bio])
        }
        catch {
            print("DEBUG: Error saving user data: \(error.localizedDescription)")
        }
    }
    
    func forgotPassword(email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        }
        catch {
            print("DEBUG: Failed to send forgot password email \(error.localizedDescription)")
        }
    }
}
