//
//  SignInView.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/19.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @StateObject private var emailValidation = DefaultTextFieldViewModel(rules: ValidationRules.emailRules)
    @StateObject private var passwordValidation = DefaultTextFieldViewModel(rules: ValidationRules.passwordRules)
    
    @State private var isAnimating: Bool = false
    @State private var isContentVisible: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                Color.white
                Circle()
                    .fill(Color.lightPurple)
                    .frame(width: 690, height: 690)
                    .offset(x: -150, y: -400)
                Circle()
                    .fill(Color.lightPurple)
                    .frame(width: 690, height: 690)
                    .offset(x: 150, y: 450)
                
                ScrollView(showsIndicators: false) {
                    Group {
                        viewContent
                          
                    }
                    .padding(.horizontal, 24)
                }
                .frame(width: UIScreen.main.bounds.width)
                
            }
            .safeAreaInset(edge: .bottom) {
                safeAreaContent
            }
        }
    }
    
    var viewContent: some View {
        VStack(alignment: .center, spacing: 16) {
            Group {
                Text("Sign In")
                    .font(.h1)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 36)
                
                DefaultTextInput(vm: emailValidation, placeholder: "Email Address")
                DefaultTextInput(vm: passwordValidation, placeholder: "Password")
                
                Text("Forgot password?")
                    .font(.caption12)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    var safeAreaContent: some View {
        Group {
            VStack(alignment: .center, spacing: 16) {
                Button(action: {
                    signIn(email: emailValidation.text, password: passwordValidation.text)
                }, label: {
                    Text("Sign In")
                })
                .disabled(!formIsValid)
                
                Spacer()
                
                NavigationLink(destination: {
                    RegisterView()
                        .navigationBarBackButtonHidden(true)
                }) {
                    HStack(spacing: 2) {
                        Text("Don't have an account?")
                            .font(.caption12)
                            .foregroundColor(.gray2)
                        Text("Sign up")
                            .font(.caption12Medium)
                            .foregroundColor(.gray2)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func signIn(email: String, password: String) {
        Task {
            try await viewModel.signIn(withEmail: email, password: password)
        }
    }
}

extension SignInView: AuthFormProtocol {
    var formIsValid: Bool {
        return emailValidation.isValid && passwordValidation.isValid
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
