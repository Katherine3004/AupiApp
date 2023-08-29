//
//  HomeCoordinator.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/15.
//

import SwiftUI
import UIKit
import Foundation

class HomeCoordinator: NSObject, Coordinator, UINavigationControllerDelegate, ObservableObject {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = UIHostingController(rootView: HomeView(coordinator: self))
        vc.tabBarItem = UITabBarItem(title: "Home",
                                     image: UIImage(systemName: "magnifyingglass.circle")?.withRenderingMode(.alwaysOriginal),
                                     selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")?.withRenderingMode(.alwaysOriginal))
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showAupairProfile(id: String) {
        let vc = UIHostingController(rootView: PublicProfileView(id: id))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popView() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func dismissView() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
