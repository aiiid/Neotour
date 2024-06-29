//
//  DetailsViewController.swift
//  NeoTour
//
//  Created by Ai Hawok on 26/06/2024.
//

import UIKit

class DetailViewController: UIViewController {
    private let detailView = DetailView()
    //put review to viewmodel and pick from there
    private var reviews: [Review] = []
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReviews()
        setupDataSource()
        setupTargets()
        setupNotificationObserver()
    }
    //instead of load reviews, put it into view model
    private func loadReviews() {
        // Load your reviews here
        reviews = [
            Review(
                username: "User1",
                userImage: "person.circle",
                review: "Great place!"
            ),
            Review(
                username: "User2",
                userImage: "person.circle",
                review: "Amazing experience. Lorem ipsum great cuisine rlloo lalalosgd odsosl oo kkk lals fasoifhsfn nnummi lasinfoo lasnfoief klnasf o",
                images: ["dummy1.jpg", "dummy2.jpg", "dummy3.jpg"]) ,
        ]
        detailView.reviewsTableView.reloadData()
    }
    
    private func setupDataSource() {
        detailView.reviewsTableView.dataSource = self
        detailView.reviewsTableView.delegate = self
    }
    
    private func setupTargets() {
        detailView.bookNowButton.addTarget(self, action: #selector(bookNowTapped), for: .touchUpInside)
        
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(showPopup), name: NSNotification.Name("BookingViewControllerDismissed"), object: nil)
    }
    
    @objc private func leftButtonTapped() {
        print("Left button tapped")
    }
    
    @objc private func bookNowTapped() {
        
        let bookingPopupVC = BookingViewController()
        if let sheet = bookingPopupVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()] // Configure as needed
            sheet.prefersGrabberVisible = true
        }
        present(bookingPopupVC, animated: true, completion: nil)
    }
    @objc private func showPopup() {
        DispatchQueue.main.async {
            let popUp = PopupViewController(title: "Popup", message: "This is a popup message.", buttonTitle: "Ok")
            popUp.modalPresentationStyle = .overFullScreen
            popUp.modalTransitionStyle = .crossDissolve
            self.present(popUp, animated: true)
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.reuseIdentifier, for: indexPath) as? ReviewCell else {
            return UITableViewCell()
        }
        let review = reviews[indexPath.row]
        cell.configure(with: review)
        return cell
    }
}
