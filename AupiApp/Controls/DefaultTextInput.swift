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
    
    var rules: [((String) -> Bool, String)]
    
    init(rules: [((String) -> Bool, String)] = []) {
            self.rules = rules
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
    
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(placeholder, text: $vm.text)
                .padding(10)
                .background(Color.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(vm.isEditing ? Color.blue : Color.gray, lineWidth: 1)
                )
                .onTapGesture {
                    vm.isEditing = true
                }
            if !vm.errorMessage.isEmpty {
                Text(vm.errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
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
        DefaultTextInput(vm: vm, placeholder: "Enter")
    }
}
