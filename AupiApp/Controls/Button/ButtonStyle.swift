//
//  ButtonStyle.swift
//  Aupi
//
//  Created by Katherine Chambers on 2023/03/03.
//

import SwiftUI

struct ExploreCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 16.0, *) {
            configuration.label
                .tracking(0.2)
                .foregroundColor(.white)
                .padding([.top, .bottom], 16)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill()
//                        .foregroundColor(configuration.isPressed ? .pnpBlueDark : .pnpBlue)
                        .foregroundColor(.white)
                )
                .scaleEffect(configuration.isPressed ? 0.98 : 1)
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
        } else {
            configuration.label
                .foregroundColor(.white)
                .padding([.top, .bottom], 16)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill()
//                        .foregroundColor(configuration.isPressed ? .pnpBlueDark : .pnpBlue)
                        .foregroundColor(.white)
                )
                .scaleEffect(configuration.isPressed ? 0.98 : 1)
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
        }
    }
}

struct ProfileCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 16.0, *) {
            configuration.label
                .tracking(0.2)
//                .foregroundColor(.white)
                .padding(.all, 24)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
//                        .foregroundColor(configuration.isPressed ? .pnpBlueDark : .pnpBlue)
                        .foregroundColor(.white)
                )
                .scaleEffect(configuration.isPressed ? 0.98 : 1)
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
        } else {
            configuration.label
//                .foregroundColor(.white)
                .padding(.all, 24)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
//                        .foregroundColor(configuration.isPressed ? .pnpBlueDark : .pnpBlue)
                        .foregroundColor(.white)
                )
                .scaleEffect(configuration.isPressed ? 0.98 : 1)
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
        }
    }
}
