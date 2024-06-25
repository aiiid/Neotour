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
        view.backgroundColor = .white
        setupViewModel()
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
//        viewModel.completeOnboarding()
        print("lets go tapped")
//        let mainViewModel = MainViewModel()
//        let mainVC = MainViewController(viewModel: mainViewModel)
//        let navigationController = UINavigationController(rootViewController: mainVC)
//        navigationController.modalPresentationStyle = .fullScreen
//        present(navigationController, animated: true, completion: nil)
    }
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
