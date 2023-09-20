//
//  ProfileView.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/19.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State private var user: User? = nil
    @State private var canEdit: Bool = false
    
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    var width = ((UIScreen.main.bounds.width / 3) - 32)
    
    weak var coordinator: ProfileCoordinator?
    
    var body: some View {
        Group {
            if user?.isAupair ?? false {
                aupairProfile(user: user ?? nil)
            }
            else {
               
            }
        }
        .safeAreaInset(edge: .bottom) {
            if canEdit {
                Button(action: {
                    updateInfo(profileImage: selectedImage)
                }, label: {
                    Text("Update")
                })
                .buttonStyle(PrimaryButtonStyle())
                .padding(.all, 24)
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: { canEdit.toggle() }, label: { Text(canEdit ? "Cancel" : "Edit Profile")})
                    Button(action: { coordinator?.showSettings() }, label: { Text("Settings")})
                    Button(action: { signout() }, label: { Text("Sign Out")})
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .renderingMode(.template)
                        .foregroundColor(Color.gray2)
                }
            }
        }
        .onAppear {
            Task {
                do {
                    guard let currentUser = viewModel.currentUser else { return }
                    user = currentUser
                }
            }
        }
    }
    
    //Aupair Content
    private func aupairProfile(user: User?) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 16) {
                Text("\(user?.fullname ?? "")")
                    .font(.h7)
                    .foregroundColor(.gray2)

                Button(action: {
                    isImagePickerPresented.toggle()
                }, label: {
                    if let imageUrl = URL(string: user?.profilePictureUrlString ?? "") {
                        ProfileImageView(imageURL: imageUrl)
                    }
                    else {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                        }
                        else {
                            Image(systemName: "person")
                                .frame(width: 130, height: 130)
                                .background(Color.lightPurple)
                                .clipShape(Circle())
                        }
                    }
                })
                .frame(width: 130, height: 130)
                .clipShape(Circle())
                .disabled(!canEdit)
           
                Text(user?.bio ?? "")
                    .font(.body14SemiBold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.gray2)
                    .padding(.bottom, 8)

                aboutContent(user: user)
                    .padding(.bottom, 16)
                
                HStack(alignment: .center, spacing: 16) {
                    ProfileSegment(image: "circle.grid.cross.up.filled",
                                   title: "Resume",
                                   backgroundColor: Color.lightPeach,
                                   imageColor: Color.mediumPeach) {}

                    ProfileSegment(image: "circle.grid.cross.right.filled",
                                   title: "Education",
                                   backgroundColor: Color.lightBlue,
                                   imageColor: Color.mediumBlue) {}
                }
                .frame(maxWidth: .infinity)

                HStack(alignment: .center, spacing: 16) {
                    ProfileSegment(image: "circle.grid.cross.left.filled",
                                   title: "Certificates",
                                   backgroundColor: Color.lightAppPink,
                                   imageColor: Color.appPink) {}

                    ProfileSegment(image: "circle.grid.cross.down.filled",
                                   title: "Other",
                                   backgroundColor: Color.lightYellow,
                                   imageColor: Color.mediumYellow) {}
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding(.all, 24)
        }
    }
    
    //About Content
    private func aboutContent(user: User?) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("About")
                .font(.body18SemiBold)
                .foregroundColor(.gray2)

            HStack(alignment: .center, spacing: 16) {
                VStack(alignment: .center, spacing: 2) {
                    Text("Age")
                        .font(.body14SemiBold)
                        .foregroundColor(.white)
                    if let age = user?.age {
                        Text("\(age)")
                            .font(.caption12)
                            .foregroundColor(.white)
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .frame(width: width)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.darkPurple)
                )
                VStack(alignment: .center, spacing: 2) {
                    Text("Location")
                        .font(.body14SemiBold)
                        .foregroundColor(.white)
                    Text(user?.location ?? "N/A")
                        .font(.caption12)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .frame(width: width)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.darkPurple)
                )

                VStack(alignment: .center, spacing: 2) {
                    Text("Experience")
                        .font(.body14SemiBold)
                        .foregroundColor(.white)
                    Text(user?.yearsOfExperience ?? "N/A")
                        .font(.caption12)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .frame(width: width)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.darkPurple)
                )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.lightPurple)
        )
    }
    
    func updateInfo(profileImage: UIImage? = nil, cvData: Data? = nil, bio: String? = nil) {
        Task {
            try await viewModel.updateProfile(profileImage: profileImage, cvData: cvData, bio: bio)
        }
    }
    
    //Sign out
    func signout() {
        Task {
            viewModel.signOut()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ProfileImageView: View {
    let imageURL: URL

    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            @unknown default:
                EmptyView()
            }
        }
    }
}
