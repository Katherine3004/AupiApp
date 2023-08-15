//
//  AppTabController.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/08/15.
//

import SwiftUI
import UIKit
import Combine

protocol TabIndexDelegate {
    func setTabIndex(index: Int)
}

struct AppTabController: UIViewControllerRepresentable {
   
    let viewModel: AuthenticationViewModel
    
    func makeUIViewController(context: Context) -> TabController {
        TabController()
    }
    
    func updateUIViewController(_ uiViewController: TabController, context: Context) {
    }
    
    typealias UIViewControllerType = TabController
}

class TabController: UITabBarController, TabIndexDelegate {
    
    private let homeCoordinator: HomeCoordinator
    private let chatCoordinator: ChatCoordinator
    private let profileCoordinator: ProfileCoordinator
    
    init() {
        self.homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
        self.chatCoordinator = ChatCoordinator(navigationController: UINavigationController())
        self.profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white

            setTabBarItemBadgeAppearance(appearance.stackedLayoutAppearance)
            setTabBarItemBadgeAppearance(appearance.inlineLayoutAppearance)
            setTabBarItemBadgeAppearance(appearance.compactInlineLayoutAppearance)
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        homeCoordinator.start()
        chatCoordinator.start()
        profileCoordinator.start()
        
        viewControllers = [homeCoordinator.navigationController,
                           chatCoordinator.navigationController,
                           profileCoordinator.navigationController]
    }
    
    private func setTabBarItemBadgeAppearance(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.badgeBackgroundColor = UIColor(hex: 0x93C6E7, alpha: 1)
        
        itemAppearance.selected.iconColor = UIColor(hex: 0x93C6E7, alpha: 1)
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(hex: 0x93C6E7, alpha: 1)]
        
    }
    
    func setTabIndex(index: Int) {
        self.selectedIndex = index
    }
    
}
