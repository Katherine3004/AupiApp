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
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack(spacing: 12) {
                        Text(user.initials ?? "")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .accentColor(.gray)
                        }
                    }
                }

                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }

                Section("Account") {
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign out", tintColor: .red)
                    })

                    Button(action: {

                    }, label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                    })
                }
            }
        }
//        Text("Sign out")
//            .onTapGesture {
//                Task {
//                    viewModel.signOut()
//                }
//            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
