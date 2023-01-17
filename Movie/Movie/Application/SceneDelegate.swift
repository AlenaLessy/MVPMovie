// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сцена
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController()
        let assemblyModuleBuilder = AssemblyModuleBuilder()
        let router = MoviesRouter(
            navigationController: navigationController,
            assemblyModuleBuilder: assemblyModuleBuilder
        )
        router.initialViewController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.backgroundColor = .black
        self.window = window
    }
}
