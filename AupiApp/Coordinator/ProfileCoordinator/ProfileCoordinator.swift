//
//  ProfileCoordinator.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/15.
//

import SwiftUI
import UIKit
import Foundation

class ProfileCoordinator: NSObject, Coordinator, UINavigationControllerDelegate, ObservableObject {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = UIHostingController(rootView: ProfileView(coordinator: self))
        vc.tabBarItem = UITabBarItem(title: "Account",
                                     image: UIImage(systemName: "person.crop.circle")?.withRenderingMode(.alwaysOriginal),
                                     selectedImage: UIImage(systemName: "person.crop.circle.fill")?.withRenderingMode(.alwaysOriginal))
        navigationController.pushViewController(vc, animated: false)
    }
    
    //Settings
    func showSettings() {
        let vc = UIHostingController(rootView: SettingsView())
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    //Pop view
    func popView() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    //Dismiss
    func dismissView() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
