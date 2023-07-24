//
//  Checkbox.swift
//  Aupi
//
//  Created by Katherine Chambers on 2023/05/18.
//

import SwiftUI

struct Checkbox: View {
    
    @Binding var checked: Bool
    let title: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            RoundedRectangle(cornerRadius: 4)
                .strokeBorder(Color.lightPurple, lineWidth: 2)
                .frame(width: 24, height: 24)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(checked ? Color.lightPurple : .white)
                        .shadow(color: .black.opacity(0.2), radius: checked ? 1 : 0, x: 0, y: checked ? 1 : 0)
                )
                
                .overlay(
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                )
            
            Text(title)
                .font(.body16SemiBold)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                self.checked.toggle()
            }
        }
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Checkbox(checked: .constant(true), title: "I am an Aupair")
    }
}
