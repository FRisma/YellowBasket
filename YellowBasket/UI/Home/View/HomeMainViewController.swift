//
//  HomeMainViewController.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class HomeMainViewController: UIViewController, HomeMainControllerProtocol {
    
    private var itemsList: [Item]? {
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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: 50, height: 100)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let categoryView: CategoryListView = {
        let cv = CategoryListView()
        cv.backgroundColor = kCategoriesBackgroundColor
        return cv
    }()
    
    private let activityIndicator = LoadingIndicator.shared
    
    private var presenter: HomeMainPresenterProtocol!
    private let headerIdentifier = "header"
    private let cellIdentifier = "cell"
    
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    init(withPresenter presenter:HomeMainPresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kHomeBackgroundColor
        
        setupView()
        applyConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.setViewDelegate(delegate: self)
    }
    
    //MARK: HomeMainControllerProtocol
    func update(categories: [Category]) {
        self.categories = categories
    }
    
    func update(products: [Item]) {
        self.itemsList = products
    }
    
    func goToDetailsView(forItem item: Item) {
        let vc = ProductDetailsMainViewController(withItem: item, usingPresenter: ProductDetailsMainViewPresenter())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToDetailsView(forCategory category: Category) {
    }
    
    func showErrorMessage(message: String) {
        //TODO
    }
    
    func showLoadingIndicator() {
        view.addSubview(activityIndicator)
    }
    
    func hideLoadingIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    //MARK: Internal
    private func setupSearchController() {
        self.definesPresentationContext = true
        search.dimsBackgroundDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.delegate = self
        self.navigationItem.titleView = search.searchBar
    }
    
    private func setupView() {
        setupSearchController()
        
        categoryView.delegate = self
        //view.addSubview(categoryView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(CategoryListView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        view.addSubview(collectionView)
    }
    
    private func applyConstraints() {
        //        categoryView.snp.makeConstraints { (make) in
        //            make.top.equalTo(scrollView).inset(2)
        //            make.left.right.equalTo(view)
        //            make.height.equalTo(90)
        //        }
        collectionView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalTo(view)
            }
            make.left.bottom.right.equalTo(view).inset(5)
        }
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
        cell.alpha = 0
        cell.backgroundColor = .white
        cell.imageURL = anItem.thumbnail
        cell.priceLabel.text = String(anItem.price)
        cell.descriptionLabel.text = anItem.title
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            cell.alpha = 1
        }, completion: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.touched(item: itemsList![indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView: CategoryListView? = nil
        if kind ==  UICollectionElementKindSectionHeader {
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as? CategoryListView
        }
        return headerView!
    }
}

extension HomeMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = view.frame.width / 2 - ((collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0)
        return CGSize(width: widthPerItem, height: widthPerItem * 1.15)
    }
}

extension HomeMainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text, query.count > 0 else {
            return
        }
        self.presenter.searchingForText(query)
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
