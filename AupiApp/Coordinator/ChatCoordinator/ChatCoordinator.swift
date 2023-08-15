//
//  ChatCoordinator.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/15.
//

import SwiftUI
import UIKit
import Foundation

class ChatCoordinator: NSObject, Coordinator, UINavigationControllerDelegate, ObservableObject {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = UIHostingController(rootView: ChatLandingView())
        vc.tabBarItem = UITabBarItem(title: "Chat",
                                     image: UIImage(systemName: "message"),
                                     selectedImage: UIImage(systemName: "message.fill"))
        navigationController.pushViewController(vc, animated: false)
    }
    
    func popView() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func dismissView() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
