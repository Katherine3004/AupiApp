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
        VStack(alignment: .center, spacing: 12) {
            Group {
                Text("Sign In")
                    .font(.h1)
                    .foregroundColor(Color(hex: 0x2b0a47, alpha: 1))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 36)
                
                DefaultTextInput(vm: emailValidation, placeholder: "Email Address")
                DefaultTextInput(vm: passwordValidation, isPassword: true, placeholder: "Password")
                
                Button(action: {  }, label: {
                    Text("Forgot password?")
                        .font(.caption12)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                .buttonStyle(PlainButtonStyle())
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
                .buttonStyle(PrimaryButtonStyle())
                .padding(.horizontal, 24)
                
                Spacer()
                
                NavigationLink(destination: {
                    RegisterView()
                        .navigationBarBackButtonHidden(true)
                }) {
                    HStack(spacing: 2) {
                        Text("Don't have an account?")
                            .font(.caption12)
                            .foregroundColor(.gray2)
                        Text("Register")
                            .font(.caption12Medium)
                            .foregroundColor(.gray2)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 32)
        }
    }
    
    func signIn(email: String, password: String) {
        Task {
            try await viewModel.signIn(withEmail: email, password: password)
        }
    }
    
    func forgotPassword() {
        Task {
            do {
                try await viewModel.forgotPassword(email: emailValidation.text)
                print("email sent")
            }
            catch {
                //Error Dialog
                print(error.localizedDescription)
            }
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
