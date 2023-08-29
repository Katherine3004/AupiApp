//
//  ProfileCardView.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/14.
//

import SwiftUI

struct ProfileCardView: View {
    
    let initials: String
    let fullName: String
    let image: String?
    let age: String?
    let location: String?
    let onTap: () -> ()
    
    init(initials: String, fullName: String, image: String? = nil, age: String? = nil, location: String? = nil, onTap: @escaping () -> ()) {
        self.initials = initials
        self.fullName = fullName
        self.image = image
        self.age = age
        self.location = location
        self.onTap = onTap
    }
    
    var body: some View {
        Button(action: { onTap() }, label: {
            HStack(alignment: .center, spacing: 16) {
                Group {
                    if let image = image, let imageUrl = URL(string: image) {
                        AsyncImage(url: imageUrl) { state in
                            switch state {
                            case .empty:
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(Color.lightPurple)
                                    .clipShape(Circle())
                            case .success(let loadedImage):
                                loadedImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(Color.lightPurple)
                                    .clipShape(Circle())
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.lightPurple)
                            .clipShape(Circle())
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(fullName.capitalized)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Age: \(age ?? "")")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    Text("Location: \(location ?? "")")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            }
            
        })
        .buttonStyle(ExploreCardButtonStyle())
    }
}

struct ProfileCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            ProfileCardView(initials: "KC", fullName: "Katherine Chambers", image: "", age: "24", location: "Durban North", onTap: {})
                .padding(.horizontal, 24)
        }
        .background(Color.disable)
    }
}
