//
//  DetailsImageAndTitleView.swift
//  YellowBasket
//
//  Created by Franco Risma on 01/08/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class DetailsImageAndTitleView: UIView {
    
    var delegate: DetailsImageAndTitleViewProtocol? {
        didSet {
            work()
        }
    }
    
    var imagesArray = [String]()
    
    private let carouselPreview: UIImageView = {
        let cp = UIImageView()
        cp.contentMode = .scaleAspectFill
        cp.clipsToBounds = true
        return cp
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
        pl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return pl
    }()

    //MARK: Public
    func reloadData() {
        if delegate != nil {
            work()
        }
    }
    
    //MARK: Internal
    private func work() {
        backgroundColor = kHomeBackgroundColor
        
        addSubview(carouselPreview)
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        let singleTapGR  = UITapGestureRecognizer   (target: self, action: #selector(DetailsImageAndTitleView.imageTapped(tapGestureRecognizer:)))
        let swipeGR  = UISwipeGestureRecognizer (target: self, action: #selector(DetailsImageAndTitleView.imageSwipeHandler(_:)))
        carouselPreview.isUserInteractionEnabled = true
        carouselPreview.addGestureRecognizer(singleTapGR)
        carouselPreview.addGestureRecognizer(swipeGR)
        
        let productUrlArray = delegate!.detailsImageView(imagesStringArrayForProductInView: self)
        let productTitle = delegate!.detailsImageView(titleForProductInView: self)
        let productPrice = delegate!.detailsImageView(priceForProductInView: self)
        
        self.isUserInteractionEnabled = true
        
        titleLabel.text = productTitle
        priceLabel.text = productPrice
        if !productUrlArray.isEmpty {
            if let url = URL(string: productUrlArray.first!) {
                carouselPreview.af_setImage(withURL: url)
            }
        }
        
        carouselPreview.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            //make.size.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(carouselPreview.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(2)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.bottom.left.right.equalToSuperview().inset(2)
        }
    }
    
    @objc func imageSwipeHandler(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizerDirection.right {
            print("Right")
        }
        
        if sender.direction == UISwipeGestureRecognizerDirection.left {
            print("Left")
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.delegate?.carouselImageTapped!()
    }
}
