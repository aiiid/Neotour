//
//  OnboardingViewController.swift
//  NeoTour
//
//  Created by Ai Hawok on 25/06/2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    let onboardingView = OnboardingView()
    var viewModel: OnboardingViewModel!
    
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let font = UIFont(name: "SFProDisplay-Regular", size: 36) {
            print("Font loaded successfully: \(font)")
        } else {
            print("Failed to load the font.")
        }
        view.backgroundColor = .white
        setupViewModel()
        setupTargets() // Add this line to ensure targets are set up
    }
    
    private func setupTargets() {
        onboardingView.letsGoButton.addTarget(
            self,
            action: #selector(letsGoTapped),
            for: .touchUpInside
        )
    }
    
    private func setupViewModel() {
        viewModel = OnboardingViewModel()
    }
    
    @objc func letsGoTapped() {
        print("lets go tapped")
//        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        let mainViewController = MainViewController() // Replace with your initial view controller
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first {
                
                window.rootViewController = navigationController
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
    }
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
