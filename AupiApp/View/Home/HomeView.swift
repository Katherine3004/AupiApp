//
//  HomeView.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/19.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var filteredAupairUsers: [User] {
        return viewModel.allUsers.filter { $0.isAupair }
    }
    
    var body: some View {
        viewContent
            .safeAreaInset(edge: .bottom) {
                safeAreaContent
            }
    }
    
    var viewContent: some View {
        Group {
            if viewModel.currentUser?.isAupair == true {
                aupairView
            }
            else {
                familyView
            }
        }
    }
    
    var aupairView: some View {
        VStack {
            Text("You chose aupair")
            Button(action: {
                Task {
                    try await viewModel.updateProfile(bio: "Update bio test")
                }
            }, label: {
                Text("Update Bio")
            })
            .buttonStyle(PrimaryButtonStyle())
        }
    }
    
    var familyView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(filteredAupairUsers, id: \.id) { user in
                    ProfileCardView(initials: user.initials, fullName: user.fullname, onTap: {})
                }
            }
        }
    }
    
    var safeAreaContent: some View {
        Text("Sign out")
            .onTapGesture {
                Task {
                    viewModel.signOut()
                }
            }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
