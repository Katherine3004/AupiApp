//
//  CustomNavigationBackButton.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/29.
//

import Foundation
import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image("back-arrow")
        })
    }
}

struct CustomNavigationBackButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

extension View {
    func customNavigationBar() -> some View {
        self.modifier(CustomNavigationBackButton())
    }
}
