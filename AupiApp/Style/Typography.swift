//
//  Typography.swift
//  Aupi
//
//  Created by Katherine Chambers on 2023/04/25.
//

import SwiftUI

extension Font {
    //Heading
    static let h1 = Font.custom("Nunito-Bold", size: 48)
    static let h2 = Font.custom("Nunito-Bold", size: 42)
    static let h3 = Font.custom("Nunito-Bold", size: 36)
    static let h4 = Font.custom("Nunito-Bold", size: 32)
    static let h5 = Font.custom("Nunito-Bold", size: 28) 
    static let h6 = Font.custom("Nunito-Bold", size: 24)
    static let h7 = Font.custom("Nunito-Bold", size: 20)
    
    static let body18 = Font.custom("Nunito-Regular", size: 18)
    static let body18SemiBold = Font.custom("Nunito-SemiBold", size: 18)
    static let body16 = Font.custom("Nunito-Regular", size: 16)
    static let body16SemiBold = Font.custom("Nunito-SemiBold", size: 16)
    static let body14 = Font.custom("Nunito-Regular", size: 14)
    static let body14SemiBold = Font.custom("Nunito-SemiBold", size: 14)
    
    static let caption12 = Font.custom("Nunito-Regular", size: 12)
    static let caption12Medium = Font.custom("Nunito-Medium", size: 12)
    static let caption10 = Font.custom("Nunito-Regular", size: 10)
    static let caption10Medium = Font.custom("Nunito-Medium", size: 10)
}



extension UIFont {
    static let appHeading = UIFont(name: "Nunito-Bold", size: 48)!
    static let h1 = UIFont(name: "Nunito-Bold", size: 48)!
    static let h2 = UIFont(name: "Nunito-Bold", size: 42)!
    static let h3 = UIFont(name: "Nunito-Bold", size: 36)!
    static let h4 = UIFont(name: "Nunito-Bold", size: 32)!
    static let h5 = UIFont(name: "Nunito-Bold", size: 28)!
    static let h6 = UIFont(name: "Nunito-Bold", size: 24)!
    static let h7 = UIFont(name: "Nunito-Bold", size: 20)!
    
    static let body18 = UIFont(name: "Nunito-Regular", size: 18)!
    static let body18SemiBold = UIFont(name: "Nunito-SemiBold", size: 18)!
    static let body16 = UIFont(name: "Nunito-Regular", size: 16)!
    static let body16SemiBold = UIFont(name: "Nunito-SemiBold", size: 16)!
    static let body14 = UIFont(name: "Nunito-Regular", size: 14)!
    static let body14SemiBold = UIFont(name: "Nunito-SemiBold", size: 14)!
    
    static let caption12 = UIFont(name: "Nunito-Regular", size: 12)!
    static let caption12Medium = UIFont(name: "Nunito-Medium", size: 12)!
    static let caption10 = UIFont(name: "Nunito-Regular", size: 10)!
    static let caption10Medium = UIFont(name: "Nunito-Medium", size: 10)!
}

struct Typography: View {
    var body: some View {
        VStack {
            Text("Hello")
                .font(Font.custom("Nunito-Regular", size: 48))
            Text("Hello")
                .font(Font.custom("Nunito-Medium", size: 48))
            Text("Hello")
                .font(Font.custom("Nunito-SemiBold", size: 48))
            Text("Hello")
                .font(Font.custom("Nunito-Bold", size: 48))
        }
    }
}

struct Typography_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
            .font(.h1)
        Text("Hello")
            .font(.body18)
        Text("Hello")
            .font(.body18SemiBold)
        Text("Hello")
            .font(.caption12)
    }
}
