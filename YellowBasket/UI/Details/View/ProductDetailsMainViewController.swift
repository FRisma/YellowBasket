//
//  ProductDetailsMainViewController.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class ProductDetailsMainViewController: UIViewController, ProductDetailsMainControllerProtocol {
    
    private var presenter: ProductDetailsMainPresenterProtocol!
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let tl = UILabel(frame: .zero)
        tl.numberOfLines = 4
        tl.font = UIFont.systemFont(ofSize: 32, weight: .light)
        return tl
    }()
    private let priceLabel: UILabel = {
        let pl = UILabel(frame: .zero)
        pl.numberOfLines = 1
        pl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return pl
    }()
    private let descriptionLabel: UILabel = {
        let dl = UILabel(frame: .zero)
        dl.numberOfLines = 0
        dl.lineBreakMode = .byWordWrapping
        dl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return dl
    }()
    private let activityIndicator = LoadingIndicator.shared
    
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    init(withItem item: Item, usingPresenter presenter: ProductDetailsMainPresenterProtocol) {
        self.presenter = presenter
        self.presenter.setProduct(item)
        super.init(nibName: nil, bundle: nil)
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = kHomeBackgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(descriptionLabel)
        
        applyConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.setViewDelegate(delegate: self)
    }
    
    //MARK: Internal
    func showErrorMessage(message: String) {
        //TODO
    }
    
    func showLoadingIndicator() {
        view.addSubview(activityIndicator)
    }
    
    func hideLoadingIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    func updateInfoForProduct(_ product: Item) {
        titleLabel.text = product.title
        priceLabel.text = String(product.price)
    }
    
    func updateProductDescription(_ descr: String) {
        descriptionLabel.text = descr
    }
    
    //MARK: Internal
    private func applyConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.left.right.equalTo(view).inset(2)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.right.equalTo(view).inset(2)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.left.right.equalTo(view).inset(10)
            make.bottom.equalTo(scrollView)
        }
    }

}
