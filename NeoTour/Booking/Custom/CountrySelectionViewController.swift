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

class CountrySelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let countries: [Country] = [
        Country(flag: "🇰🇿", code: "+7"),
        Country(flag: "🇺🇸", code: "+1"),
        Country(flag: "🇨🇦", code: "+1"),
        // Add more countries here
    ]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "countryCell")
        return tableView
    }()
    
    var didSelectCountry: ((Country) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        preferredContentSize = CGSize(width: 250, height: 300)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = "\(country.flag) \(country.code)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        didSelectCountry?(country)
        dismiss(animated: true, completion: nil)
    }
}
