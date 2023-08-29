//
//  PublicProfileView.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/28.
//

import SwiftUI

struct PublicProfileView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    let id: String
    
    var body: some View {
        if let user = viewModel.allUsers.first(where: { $0.id == id }) {
            VStack(alignment: .center) {
                Text(user.fullname)
            }
        }
    }
}

struct PublicProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PublicProfileView(id: "")
    }
}
