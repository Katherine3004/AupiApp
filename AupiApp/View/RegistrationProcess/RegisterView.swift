//
//  RegisterView.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/19.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @StateObject private var emailValidation = DefaultTextFieldViewModel(rules: ValidationRules.emailRules)
    @StateObject private var firstnameValidation = DefaultTextFieldViewModel(rules: ValidationRules.firstNameRules)
    @StateObject private var lastnameValidation = DefaultTextFieldViewModel(rules: ValidationRules.lastNameRules)
    @StateObject private var passwordValidation = DefaultTextFieldViewModel(rules: ValidationRules.passwordRules)
    
    @State private var aupairChecked: Bool = false
    
    var showErrorDialog: Binding<Bool> {
        Binding<Bool>(
            get: { !viewModel.errorDescription.isEmpty },
            set: { newValue in
                if !newValue {
                    viewModel.errorDescription = ""
                }
            }
        )
    }
    
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
            .modal(isShowing: showErrorDialog) {
                TwoButtonDialogBox(title: "Registration Error",
                                   description: viewModel.errorDescription,
                                   btn1Title: "Try Again",
                                   btn2Title: "Close",
                                   btn1Tapped: { signUp() },
                                   btn2Tapped: { viewModel.errorDescription = "" })
            }
        }
    }
    
    var viewContent: some View {
        VStack(alignment: .center, spacing: 16) {
            Group {
                Text("Register")
                    .font(.h1)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 36)
                
                DefaultTextInput(vm: firstnameValidation, placeholder: "First Name")
                DefaultTextInput(vm: lastnameValidation, placeholder: "Last Name")
                DefaultTextInput(vm: emailValidation, placeholder: "Email Address")
                DefaultTextInput(vm: passwordValidation, isPassword: true, placeholder: "Password")
                Checkbox(checked: $aupairChecked, title: "I am an Aupair")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    var safeAreaContent: some View {
        Group {
            VStack(alignment: .center, spacing: 16) {
                Button(action: {
                    signUp()
                }, label: {
                    Text("Sign Up")
                })
                .disabled(!formIsValid)
                .buttonStyle(PrimaryButtonStyle())
                
                Spacer()
                
              Button(action: {
                  dismiss()
              }, label: {
                  HStack(spacing: 2) {
                      Text("Already have an account?")
                          .font(.caption12)
                          .foregroundColor(.gray2)
                      Text("Sign in")
                          .font(.caption12Medium)
                          .foregroundColor(.gray2)
                  }
                  .frame(maxWidth: .infinity, alignment: .center)
              })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 32)
        }
        .padding(.horizontal, 24)
    }
    
    func signUp() {
        Task {
            try await viewModel.createUser(withEmail: emailValidation.text,
                                           password: passwordValidation.text,
                                           firstname: firstnameValidation.text,
                                           lastname: lastnameValidation.text,
                                           isAupair: aupairChecked)
        }
    }
}

extension RegisterView: AuthFormProtocol {
    var formIsValid: Bool {
        return emailValidation.isValid && firstnameValidation.isValid && lastnameValidation.isValid && passwordValidation.isValid
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
