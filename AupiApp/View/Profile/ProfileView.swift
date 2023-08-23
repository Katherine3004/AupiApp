//
//  ProfileView.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/19.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        Text("Sign out")
            .onTapGesture {
                Task {
                    viewModel.signOut()
                }
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
