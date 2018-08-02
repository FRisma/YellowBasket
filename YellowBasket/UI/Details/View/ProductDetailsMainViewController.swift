//
//  ProductDetailsMainViewController.swift
//  YellowBasket
//
//  Created by Franco Risma on 27/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductDetailsMainViewController: UIViewController, ProductDetailsMainControllerProtocol, DetailsImageAndTitleViewProtocol {
    
    private var presenter: ProductDetailsMainPresenterProtocol!
    private let scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    private var imageAndTitleView: DetailsImageAndTitleView = {
        return DetailsImageAndTitleView()
    }()
    private let descriptionLabel: UILabel = {
        let dl = UILabel(frame: .zero)
        dl.numberOfLines = 0
        dl.lineBreakMode = .byWordWrapping
        dl.font = UIFont.systemFont(ofSize: 16, weight: .ultraLight)
        return dl
    }()
    private let activityIndicator = LoadingIndicator.shared
    private var displayingProduct: Item? {
        didSet {
            imageAndTitleView.reloadData()
        }
    }
    private var imagesArray = [String]()
    
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
        
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ProductDetailsMainViewController.actionButtonTapped(_ :)))

        view.addSubview(scrollView)
        scrollView.addSubview(imageAndTitleView)
        scrollView.addSubview(descriptionLabel)
        
        applyConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.setViewDelegate(delegate: self)
        imageAndTitleView.delegate = self
    }
    
    //MARK: ProductDetailsMainControllerProtocol
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
    
    func updateInfoForProduct(_ product: Item) {
        displayingProduct = product
        if let urlArray = product.images {
            for aStringURL in urlArray {
                imagesArray.append(aStringURL.url)
            }
        }
        imageAndTitleView.reloadData()
    }
    
    func updateProductDescription(_ descr: String) {
        descriptionLabel.text = descr
    }
    
    //MARK: DetailsImageAndTitleViewProtocol
    func detailsImageView(imagesStringArrayForProductInView: DetailsImageAndTitleView) -> [String] {
        return imagesArray
    }
    
    func detailsImageView(titleForProductInView: DetailsImageAndTitleView) -> String {
        return displayingProduct?.title ?? ""
    }
    
    func detailsImageView(priceForProductInView: DetailsImageAndTitleView) -> String {
        if let product = displayingProduct {
            return String.convert(toMoneyFromDouble: product.price ?? 0)
        }
        return "N/A"
    }
    
    func carouselImageTapped() {
        let vc = CarouselPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.urlArray = imagesArray
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    //MARK: Internal
    private func applyConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        imageAndTitleView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.height.equalTo(view.snp.height).multipliedBy(0.6)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageAndTitleView.snp.bottom).offset(15)
            make.left.right.equalTo(view).inset(10)
            make.bottom.equalTo(scrollView)
        }
    }
    
    @objc func actionButtonTapped(_ sender: UIButton) {
        if let url = displayingProduct?.sharingURL {
            let activityVC = UIActivityViewController(activityItems: ["Mira lo que encontre.",url], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}
