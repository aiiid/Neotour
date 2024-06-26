//
//  SceneDelegate.swift
//  NeoTour
//
//  Created by Ai Hawok on 25/06/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        resetUserDefaults()
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        if hasCompletedOnboarding {
            showMainScreen()
        } else {
            showOnboardingScreen()
        }
        
        window?.makeKeyAndVisible()
    }
    
    func showMainScreen() {
        let mainViewController = MainViewController() // Replace with your initial view controller
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navigationController
    }
    
    func showOnboardingScreen() {
        let onboardingViewModel = OnboardingViewModel()
        let onboardingViewController = OnboardingViewController(viewModel: onboardingViewModel)
        window?.rootViewController = onboardingViewController
    }
    
    func resetUserDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
