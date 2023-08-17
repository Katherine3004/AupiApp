//
//  SearchBar.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/17.
//

import SwiftUI

struct SearchBar: View {
    
    @FocusState private var isFocused: Bool
    
    @Binding var searchText: String

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: "magnifyingglass")
                .frame(width: 24, height: 24)
                .foregroundColor(Color.gray3)
            
            TextField("Search", text: $searchText)
                .focused($isFocused)
                .font(.body16)
            
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color.gray3)
                    .opacity(searchText.isEmpty ? 0 : 1)
            }
            .padding(.trailing)
        }
        .frame(height: 30)
        .padding(.all, 10)
        .background(Color.white)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(isFocused ? Color.mediumBlue : Color.gray5, lineWidth: 1)
        )
        .onTapGesture {
            withAnimation {
                isFocused = true
            }
        }
    }
}
//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar(searchText: .constant(""))
//    }
//}

struct TestView: View {
    @State private var searchText = ""
    @State private var array1 = ["Apple", "Banana", "Cherry"]
    @State private var array2 = ["Dog", "Elephant", "Fish"]

    var filteredArray1: [String] {
        if searchText.isEmpty {
            return array1
        } else {
            return array1.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var filteredArray2: [String] {
        if searchText.isEmpty {
            return array2
        } else {
            return array2.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
            
            List {
                ForEach(filteredArray1, id: \.self) { item in
                    Text(item)
                }
            }

            List {
                ForEach(filteredArray2, id: \.self) { item in
                    Text(item)
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
