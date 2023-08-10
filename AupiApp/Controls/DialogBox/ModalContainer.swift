//
//  Modal.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/10.
//

import SwiftUI

struct ModalContainer<Modal: View>: ViewModifier {
    
    @Binding var isShowing: Bool
    @ViewBuilder var modal: () -> Modal
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
                .zIndex(1)
            if isShowing {
                Color.black.ignoresSafeArea()
                    .zIndex(2)
                    .opacity(0.45).transition(.opacity)
                modal()
                    .padding(.bottom, 16)
                    .padding(.trailing, 16)
                    .zIndex(3)
                    .transition(.scale(scale: 0.92).combined(with: .opacity))
            }
        }
    }

}

extension View {
    func modal(isShowing: Binding<Bool>, @ViewBuilder modal: @escaping () -> some View) -> some View {
        modifier(ModalContainer(isShowing: isShowing, modal: modal))
    }
}
