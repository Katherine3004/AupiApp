//
//  HomeView.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/19.
//

import SwiftUI

struct HomeView: View {
    
    enum ActiveSheet: String, Identifiable {
        case sort, filter
        var id: String { rawValue }
    }
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State private var searchText = ""
    @State private var activeSheet: ActiveSheet? = nil
    
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
            .sheet(item: $activeSheet) { item in
                switch item {
                case .sort:
                    sortSheet
                        .presentationDetents([.medium, .large])
                case .filter:
                    filterSheet
                        .presentationDetents([.medium, .large])
                }
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
    
    var sortButton: some View {
        Button(action: {
            withAnimation {
                activeSheet = .sort
            }
        }, label: {
            HStack(alignment: .center, spacing: 8) {
                Text("Sort")
                    .font(.body14SemiBold)
                    .foregroundColor(.gray3)
                Image(systemName: activeSheet == .sort ? "chevron.up" : "chevron.down")
                    .resizable()
                    .foregroundColor(Color.gray3)
                    .frame(width: 10, height: 6)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.lightPurple, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 64).fill(.white))
            )
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    var filterButton: some View {
        Button(action: {
            withAnimation {
                activeSheet = .filter
            }
        }, label: {
            HStack(alignment: .center, spacing: 8) {
                Text("Filter")
                    .font(.body14SemiBold)
                    .foregroundColor(.gray3)
                Image(systemName: activeSheet == .filter ? "chevron.up" : "chevron.down")
                    .resizable()
                    .foregroundColor(Color.gray3)
                    .frame(width: 10, height: 6)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.lightPurple, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 64).fill(.white))
            )
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    var familyView: some View {
        VStack(alignment: .leading, spacing: 0) {
            SearchBar(searchText: $searchText)
                .padding(.bottom, 24)
            HStack(alignment: .center, spacing: 16) {
                sortButton
                filterButton
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 4)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(filteredAupairUsers, id: \.id) { user in
                        ProfileCardView(initials: user.initials, fullName: user.fullname, onTap: {})
                    }
                }
                .padding(.top, 20)
            }
        }
        .padding([.horizontal], 24)
        .background(Color.backgroundBlue)
    }
    
    var sortSheet: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Text("Sort By")
                    .font(.body18SemiBold)
                    .foregroundColor(.gray2)
                
                Spacer()
                
                Button(action: { activeSheet = nil }, label: {
                    Image(systemName: "xmark")
                        .font(.body16)
                        .foregroundColor(.gray2)
                })
                .buttonStyle(PlainButtonStyle())
            }
            .padding([.horizontal, .top], 24)
            
            ScrollView(showsIndicators: false) {
                
            }
        }
    }
    
    var filterSheet: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Text("Filter By")
                    .font(.body18SemiBold)
                    .foregroundColor(.gray2)
                
                    .font(.body16)
                    .foregroundColor(.gray2)
                
                Spacer()
                
                Button(action: { activeSheet = nil }, label: {
                    Image(systemName: "xmark")
                        .font(.body16)
                        .foregroundColor(.gray2)
                })
                .buttonStyle(PlainButtonStyle())
            }
            .padding([.horizontal, .top], 24)
            ScrollView(showsIndicators: false) {
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
