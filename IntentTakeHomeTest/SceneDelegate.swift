//
//  SceneDelegate.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 08/10/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window =  UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        window?.rootViewController = viewController()
        window?.makeKeyAndVisible()
    }

    func viewController() -> UIViewController {
       let loader = RepoSearchListService(apiClient: URLSessionHttpClient())
        let viewController = RepoSearchComposer.composedWith(repoSearchLoader: loader)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barTintColor = .white
        return navigationController
    }

}

