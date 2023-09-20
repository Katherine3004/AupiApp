//
//  PublicProfileView.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/28.
//

import SwiftUI

struct PublicProfileView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State private var user: User? = nil
    
    let id: String
    
    var width = ((UIScreen.main.bounds.width / 3) - 32)
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 16) {
                Text("\(user?.fullname ?? "")")
                    .font(.h7)
                    .foregroundColor(.gray2)

                Image(systemName: "person")
                    .frame(width: 130, height: 130)
                    .background(Color.lightPurple)
                    .clipShape(Circle())

                Text(user?.bio ?? "")
                    .font(.body14SemiBold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.gray2)
                    .padding(.bottom, 8)

                aboutContent
                    .padding(.bottom, 16)
                
                HStack(alignment: .center, spacing: 16) {
                    ProfileSegment(image: "circle.grid.cross.up.filled",
                                   title: "Resume",
                                   backgroundColor: Color.lightPeach,
                                   imageColor: Color.mediumPeach) {
                        
                    }

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
                                   title: "Test",
                                   backgroundColor: Color.lightYellow,
                                   imageColor: Color.mediumYellow) {}
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding(.all, 24)
        }
        .onAppear {
            user = viewModel.allUsers.first(where: { $0.id == id })
        }
    }
    
    var aboutContent: some View {
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
}

struct ProfileSegment: View {
    
    let image: String
    let title: String
    let backgroundColor: Color
    let imageColor: Color
    let onTap: () -> ()
    
    var body: some View {
        Button(action: {
            onTap()
        }, label: {
            VStack(alignment: .center, spacing: 8) {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                        .frame(width: 48, height: 48)
                    Image(systemName: image)
                        .resizable()
                        .foregroundColor(imageColor)
                        .frame(width: 24, height: 24)
                }
                
                Text(title)
                    .font(.body14SemiBold)
            }
            .frame(width: (UIScreen.main.bounds.width / 2) - 32, height: (UIScreen.main.bounds.width / 2) - 32)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(backgroundColor)
            )
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct PublicProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PublicProfileView(id: "")
    }
}
