//
//  HomeMainViewController.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class HomeMainViewController: UIViewController, HomeMainControllerProtocol, TrendingKeywordsViewDelegate {
    
    private var keywordsView: TrendingKewyordsView?
    
    private var itemsList: [Item]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private let search = UISearchController(searchResultsController: nil)
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let activityIndicator = LoadingIndicator.shared
    
    private var presenter: HomeMainPresenterProtocol!
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
        presenter.setViewDelegate(delegate: self)
    }
    
    //MARK: HomeMainControllerProtocol
    func update(products: [Item]) {
        keywordsView?.removeFromSuperview()
        self.itemsList = products
    }
    
    func goToDetailsView(forItem item: Item) {
        let vc = ProductDetailsMainViewController(withItem: item, usingPresenter: ProductDetailsMainViewPresenter())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToDetailsView(forCategory category: Category) {
        //TODO
    }
    
    func showErrorMessage(message: String) {
        let alertController = UIAlertController(title: "Oops...", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true)
    }
    
    func showLoadingIndicator() {
        view.addSubview(activityIndicator)
    }
    
    func hideLoadingIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    func showTrendingKeywordsView(withElements elements:[String]) {
        keywordsView = TrendingKewyordsView(withKeys: elements)
        keywordsView!.delegate = self
        view.addSubview(keywordsView!)
        view.bringSubview(toFront: keywordsView!)
        
        keywordsView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: TrendingKeywordsViewDelegate
    func tapped(onKeyword keyword: String) {
        self.presenter.searchingForText(keyword)
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        view.addSubview(collectionView)
    }
    
    private func applyConstraints() {
        collectionView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(5)
            } else {
                make.top.equalTo(view).offset(5)
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
        cell.imageURL = anItem.thumbnail!
        cell.priceLabel.text = String.convert(toMoneyFromDouble: anItem.price ?? 0)
        cell.descriptionLabel.text = anItem.title
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            cell.alpha = 1
        }, completion: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.touched(item: itemsList![indexPath.row])
    }
}

extension HomeMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = view.frame.width / 2 - ((collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0)
        return CGSize(width: widthPerItem, height: widthPerItem * 1.25)
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
