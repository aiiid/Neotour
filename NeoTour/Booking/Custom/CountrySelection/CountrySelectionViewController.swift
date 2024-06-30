//
//  CountrySelectionViewController.swift
//  NeoTour
//
//  Created by Ai Hawok on 30/06/2024.
//
import UIKit
import SnapKit

struct Country {
    let flag: String
    let code: String
}

class CountrySelectionViewController: UIViewController {
    private let viewModel = CountriesViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "countryCell")
        return tableView
    }()
    
    var didSelectCountry: ((Country) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDataSource()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        preferredContentSize = CGSize(width: 110, height: 300)
    }
    
    private func setupDataSource() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CountrySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCountries
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = viewModel.country(at: indexPath.row)
        cell.textLabel?.text = "\(country.flag) \(country.code)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = viewModel.country(at: indexPath.row)
        didSelectCountry?(country)
        dismiss(animated: true, completion: nil)
    }
}
