//
//  CountrySelectionMainViewController.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class CountrySelectionMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var availableCountries = [Country]() {
        didSet {
            availableCountries.sort { $0.name < $1.name }
            self.tableView.reloadData()
        }
    }
    
    private var tableView: UITableView = {
        return UITableView(frame: .zero)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "country")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        APIService.shared.getAvailableCountries(onSuccess: { (countries) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.availableCountries = countries
        }) { (error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print("error")
        }
    }
    

    // MARK: - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableCountries.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1
            cell.layoutIfNeeded()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath) as UITableViewCell
        cell.textLabel?.text = availableCountries[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountryIdentifier = availableCountries[indexPath.row].identifier
        UserDefaults.standard.set(selectedCountry: selectedCountryIdentifier)
        self.dismiss(animated: true, completion: nil)
    }
}
