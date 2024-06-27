//
//  DetailsViewController.swift
//  NeoTour
//
//  Created by Ai Hawok on 26/06/2024.
//

import UIKit

class DetailViewController: UIViewController {
    private let detailView = DetailView()
    private var reviews: [Review] = []
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReviews()
        setupDataSource()
    }
    
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
                images: ["dummy1.jpg","dummy2.jpg","dummy3.jpg"]),
        ]
        detailView.reviewsTableView.reloadData()
    }
    
    private func setupDataSource() {
        detailView.reviewsTableView.dataSource = self
        detailView.reviewsTableView.delegate = self
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
