//
//  HomeMainViewController.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class HomeMainViewController: UIViewController {
    
    // This will hold the items returned from the service
    private var itemsList: [Item]? {
        didSet {
            itemsFiltered = itemsList
        }
    }
    
    private var itemsFiltered: [Item]?{
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var categories: [Category]? {
        didSet {
            self.categoryView.reloadData()
        }
    }
    
    private let search = UISearchController(searchResultsController: nil)
    
    private let cellIdentifier = "cell"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = kCategoriesBackgroundColor
        return cv
    }()
    
    private let categoryView: CategoryListView = {
        return CategoryListView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = kHomeBackgroundColor
        
        categoryView.delegate = self
        view.addSubview(categoryView)
        
        categoryView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalTo(view)
            }
            make.left.right.equalTo(view)
            make.height.equalTo(90)
        }
        
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(categoryView.snp.bottom)
            make.left.bottom.right.equalToSuperview().inset(5)
        }
        
        search.searchResultsUpdater = self
        self.definesPresentationContext = true
        search.dimsBackgroundDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = search.searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        APIService.shared.getTrendingKeywords(onSuccess: { (keywordsArray) in
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            print("success")
//        }) { (error) in
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            print("error")
//        }
//        
//        APIService.shared.getTrendingKeywords(onSuccess: { (keywordsArray) in
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            print("success")
//        }) { (error) in
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            print("error")
//        }
        
        APIService.shared.getItems(forQuery: "audi a3", onSuccess: { (itemsArray) in
            self.itemsList = itemsArray
        }) { (error) in
            print("error")
        }
        
        APIService.shared.getCategories(onSuccess: { (categoriesArray) in
            self.categories = categoriesArray
        }) { (error) in
            print("error")
        }
        
//        let fakeItem = Item(identifier: "MLA679232727", title: "String", price: 123, currencyId: "<#T##String#>", quantity: 1, condition: "Nueo", thumbnail: "tuhermana")
//        APIService.shared.getDetails(forItem: fakeItem, onSuccess: { (itemDetails) in
//            print("Jamon")
//        }) { (error) in
//            print("error")
//        }
    }
}

extension HomeMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let elements = itemsList else {
            return 0
        }
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        let anItem = itemsList![indexPath.row]
        
        cell.backgroundColor = .yellow
        cell.imageURL = anItem.thumbnail
        cell.priceLabel.text = String(anItem.price)
        cell.descriptionLabel.text = anItem.title
        return cell
    }
}

extension HomeMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = view.frame.width / 2 - ((collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

extension HomeMainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        if searchText.count > 0 {
            itemsFiltered?.removeAll()
            let array = itemsList?.filter {
                return $0.title.lowercased().contains(searchText.lowercased())
            }
            itemsFiltered = array
        } else { //Reset to the original state
            if searchController.isActive {
                itemsFiltered = itemsList
            }
        }
    }
}

extension HomeMainViewController: CategoryListViewDelegate {
    
    func categoryList(numbersOfElementsInCategoryView categoryView: CategoryListView) -> Int {
        guard let categories = categories else {
            return 0
        }
        return (categories.count > 5) ? 5 : categories.count
    }
    
    func categoryList(_ categoryView: CategoryListView, viewForElementAtIndex index: Int) -> UIView {
        let label = UILabel()
        label.text = categories![index].name
        return label
    }
}
