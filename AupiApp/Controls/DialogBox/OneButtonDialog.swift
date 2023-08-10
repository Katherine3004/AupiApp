//
//  OneButtonDialog.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/10.
//

import SwiftUI

struct OneButtonDialog: View {
    
    @Binding var title: String?
    @Binding var description: String?
    
    let btnTitle: String
    let btnTapped: () -> ()
    
    init(title: Binding<String?>, description: Binding<String?>, btnTitle: String, btnTapped: @escaping () -> ()) {
        self._title = title
        self._description = description
        self.btnTitle = btnTitle
        self.btnTapped = btnTapped
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title ?? "")
                .font(.h5)
                .foregroundColor(Color.gray2)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(description ?? "")
                .font(.body16)
                .foregroundColor(Color.gray3)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: { btnTapped() }, label: {
                Text(btnTitle)
                    .foregroundColor(Color.white)
            })
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding(.all, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.16), radius: 24, x: 0, y: 8)
        )
        .frame(maxWidth: UIScreen.main.bounds.width - 48)
    }
}

struct OneButtonDialog_Previews: PreviewProvider {
    static var previews: some View {
        OneButtonDialog(title: .constant("Check Your Email"), description: .constant("We have sent you a password reset email"), btnTitle: "Okay", btnTapped: {})
    }
}
