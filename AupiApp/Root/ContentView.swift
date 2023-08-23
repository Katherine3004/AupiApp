//
//  ContentView.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/07/19.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        switch viewModel.signInState {
        case .signedIn:
            AppTabController(viewModel: viewModel)
                .ignoresSafeArea()
                .environmentObject(viewModel)
        default:
            SignInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
