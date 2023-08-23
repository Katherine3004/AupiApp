//
//  TabRow.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/17.
//

import SwiftUI

struct TabRow: View {
    
    let options: [String]
    let onTap: () -> ()
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            ForEach(options.indices, id: \.self) { index in
                Button(action: {
                    
                }, label: {
                    Text(options[index])
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                        )
                })
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let options = ["Sort", "Filter"]
        TabRow(options: options, onTap: {})
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundBlue)
    }
}
