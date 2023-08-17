//
//  HomeView.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/19.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State private var searchText = ""
    
//    var filteredAupairUsers: [User] {
//        return viewModel.allUsers.filter { $0.isAupair }
//    }
    
    var filteredAupairUsers: [User] {
        if searchText.isEmpty {
            return viewModel.allUsers.filter { $0.isAupair }
        }
        else {
            return viewModel.allUsers.filter { user in
                user.isAupair &&
                (user.firstname.localizedCaseInsensitiveContains(searchText) ||
                user.lastname.localizedCaseInsensitiveContains(searchText) ||
                user.email.localizedCaseInsensitiveContains(searchText))
            }
        }
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
        VStack(alignment: .leading, spacing: 24) {
            SearchBar(searchText: $searchText)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(filteredAupairUsers, id: \.id) { user in
                        ProfileCardView(initials: user.initials, fullName: user.fullname, onTap: {})
                    }
                }
            }
        }
        .padding(.all, 24)
        .background(Color.backgroundBlue)
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
