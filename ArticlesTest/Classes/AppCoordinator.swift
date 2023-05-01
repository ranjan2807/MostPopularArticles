//
//  AppCoordinator.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 30/04/23.
//

import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator]? { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinator: [Coordinator]? = []
    var window: UIWindow
    
    init(with window: UIWindow) {
        self.window = window
    }
    
    func start() {
        guard let articleListScreen = ArticleListViewController.initialize() else { return }
        
        let articleListCoordinator = ArticleListCoordinator(with: articleListScreen)
        articleListCoordinator.start()
        
        self.childCoordinator = self.childCoordinator! + [articleListCoordinator]
        
        self.window.rootViewController = articleListScreen
        self.window.makeKeyAndVisible()
    }
}
