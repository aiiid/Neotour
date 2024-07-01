//
//  DetailsViewController.swift
//  NeoTour
//
//  Created by Ai Hawok on 26/06/2024.
//

import UIKit

class DetailViewController: UIViewController {
    private let detailView = DetailView()
    //    private let viewModel: MainViewModel
    private let tour: TourModel
    
    override func loadView() {
        view = detailView
    }
    
    init(tour: TourModel) {
        //            self.viewModel = viewModel
        self.tour = tour
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent()
        setupDataSource()
        setupTargets()
        setupNotificationObserver()
    }
    private func loadContent() {
        detailView.reviewsTableView.reloadData()
        detailView.set(tour: tour)
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
    
    @objc private func bookNowTapped() {
        let bookingPopupVC = BookingViewController(tour: tour)
        if let sheet = bookingPopupVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
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
        return tour.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.reuseIdentifier, for: indexPath) as? ReviewCell else {
            return UITableViewCell()
        }
        let review = tour.reviews[indexPath.row]
        cell.configure(with: review)
        return cell
    }
}
