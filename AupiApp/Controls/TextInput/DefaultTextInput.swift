//
//  DefaultTextInput.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/24.
//

import SwiftUI

class DefaultTextFieldViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var isEditing: Bool = false
    @Published var errorMessage: String = ""
    @Published var autocapitalization: UITextAutocapitalizationType = .none
    var rules: [((String) -> Bool, String)]
    
    init(rules: [((String) -> Bool, String)] = []) {
            self.rules = rules
    }
    
    var isValid: Bool {
        for rule in rules {
            if !rule.0(text) {
                return false
            }
        }
        return true
    }
    
    func validate() {
        errorMessage = ""
        for rule in rules {
            if !rule.0(text) {
                errorMessage = rule.1
                break
            }
        }
    }
}

struct DefaultTextInput: View {
    
    @ObservedObject var vm: DefaultTextFieldViewModel
    
    @FocusState private var isFocused: Bool
    
    @State var isPassword: Bool = false
    @State var showPassword: Bool = false
    
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(placeholder)
                .font(.body16SemiBold)
                .foregroundColor(Color.gray3)
            
            if isPassword == true {
                HStack(alignment: .center, spacing: 0) {
                    if showPassword == true {
                        TextField(placeholder, text: $vm.text)
                            .focused($isFocused)
                            .font(.body16)
                    }
                    else {
                        SecureField(placeholder, text: $vm.text)
                            .focused($isFocused)
                            .font(.body16)
                    }
                    
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(Color.gray3)
                        .onTapGesture {
                            showPassword.toggle()
                        }
                }
                .frame(height: 30)
                .padding(.all, 10)
                .background(Color.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isFocused ? Color.mediumBlue : Color.gray5, lineWidth: 1)
                )
                .onTapGesture {
                    withAnimation {
                        isFocused = true
                    }
                }
            }
            else {
                TextField(placeholder, text: $vm.text)
                    .focused($isFocused)
                    .font(.body16)
                    .frame(height: 30)
                    .padding(.all, 10)
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(isFocused ? Color.mediumBlue : Color.gray5, lineWidth: 1)
                    )
                    .onTapGesture {
                        withAnimation {
                            isFocused = true
                        }
                    }
                    .autocapitalization(.sentences)
            }
            
//            if !vm.errorMessage.isEmpty {
                Text(vm.errorMessage ?? "")
                    .font(.caption12)
                    .foregroundColor(.errorRed)
                    .frame(height: 12)
                    .padding(.top, 4)
//            }
        }
        .onChange(of: vm.text) { _ in
            vm.validate()
        }
    }
}

struct DefaultTextInput_Previews: PreviewProvider {
    
    static var previews: some View {
        let vm = DefaultTextFieldViewModel()
        VStack {
            DefaultTextInput(vm: vm, placeholder: "Enter")
            DefaultTextInput(vm: vm, isPassword: true, placeholder: "Password")
        }
        .padding(.horizontal, 24)
        .frame(maxHeight: UIScreen.main.bounds.height)
        .background(Color.gray3)
    }
}
