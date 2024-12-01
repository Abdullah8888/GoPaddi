//
//  SceneDelegate.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        DIContainer.register()
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        mainCoordinator = MainCoordinator( navigationController: UINavigationController(), window: window!)
        mainCoordinator?.start()
    }
    
    func asf() {
        
    }
    func sceneDidDisconnect(_ scene: UIScene) {
    
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

