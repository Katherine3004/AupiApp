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
    
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(placeholder)
                .font(.body16SemiBold)
            TextField(placeholder, text: $vm.text)
                .focused($isFocused)
                .padding(10)
                .background(Color.white)
                .cornerRadius(5)
                .font(.body14)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isFocused ? Color.mediumBlue : Color.gray2, lineWidth: 1)
                )
                .onTapGesture {
                    withAnimation {
                        isFocused = true
                    }
                }
                .autocapitalization(vm.autocapitalization)
            
            if !vm.errorMessage.isEmpty {
                Text(vm.errorMessage)
                    .font(.caption12)
                    .foregroundColor(.errorRed)
            }
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
            DefaultTextInput(vm: vm, placeholder: "Enter")
        }
    }
}
