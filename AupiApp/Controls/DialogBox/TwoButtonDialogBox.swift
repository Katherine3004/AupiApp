//
//  TwoButtonDialogBox.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/10.
//

import SwiftUI

struct TwoButtonDialogBox: View {
    
    @Binding var title: String?
    @Binding var description: String?
    
    let btn1Title: String
    let btn2Title: String
    let btn1Tapped: () -> ()
    let btn2Tapped: () -> ()
    
    init(title: Binding<String?>, description: Binding<String?>, btn1Title: String, btn2Title: String, btn1Tapped: @escaping () -> (), btn2Tapped: @escaping () -> ()) {
        self._title = title
        self._description = description
        self.btn1Title = btn1Title
        self.btn2Title = btn2Title
        self.btn1Tapped = btn1Tapped
        self.btn2Tapped = btn2Tapped
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

            Button(action: { btn1Tapped() }, label: {
                Text(btn1Title)
            })
            .buttonStyle(PrimaryButtonStyle())
            
            Button(action: { btn2Tapped() }, label: {
                Text(btn2Title)
            })
            .buttonStyle(SecondaryButtonStyle())
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

struct TwoButtonDialogBox_Previews: PreviewProvider {
    static var previews: some View {
        TwoButtonDialogBox(title: .constant("Forgot your password?"), description: .constant("We'll email you a link to reset your password."), btn1Title: "Send me password reset link", btn2Title: "Close", btn1Tapped: {}, btn2Tapped: {})
    }
}
