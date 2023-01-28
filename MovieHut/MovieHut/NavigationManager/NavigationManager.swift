//
//  NavigationManager.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation
import UIKit

struct NavigationManager {
    // MARK: Lifecycle
    private init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Internal
    static var instance: NavigationManager?
    
    var window: UIWindow
    
    static func initialize() {
        instance = NavigationManager(window: makeNewWindow())
        instance?.bootstrap()
    }
    
    static func setupTheLanguage() {}
    
    // MARK: - Decision point to show Onboarding, Login, Home.
    mutating func bootstrap() {
        showMoviesView()
        window.makeKeyAndVisible()
    }
}

extension NavigationManager {
    private static func makeNewWindow() -> UIWindow {
        var window: UIWindow?
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            window = sceneDelegate.window
        }
        
        return window ?? UIWindow(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Start Movie Flow
    private func showMoviesView() {
        let controller = MovieListRouter.createModule()
        let nav = UINavigationController(rootViewController: controller)
        window.rootViewController = nav
    }
}
