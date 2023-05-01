//
//  SceneDelegate.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 29/04/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene
        self.window = appWindow
        
        appCoordinator = AppCoordinator(with: appWindow)
        appCoordinator?.start()
    }
}
