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
    
    var imagesURLArray = [String]()
    var currentImageDisplayingIndex = 0
    
    private let carouselPreview: UIImageView = {
        let cp = UIImageView()
        cp.contentMode = .scaleAspectFill
        cp.clipsToBounds = true
        return cp
    }()
    
    private let titleLabel: UILabel = {
        let tl = UILabel(frame: .zero)
        tl.numberOfLines = 4
        tl.font = UIFont.systemFont(ofSize: 31, weight: .thin)
        return tl
    }()
    private let priceLabel: UILabel = {
        let pl = UILabel(frame: .zero)
        pl.numberOfLines = 1
        pl.font = UIFont.systemFont(ofSize: 25, weight: .light)
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
        let swipeLeftGR  = UISwipeGestureRecognizer (target: self, action: #selector(DetailsImageAndTitleView.imageSwipeHandler(_:)))
        let swipeRightGR  = UISwipeGestureRecognizer (target: self, action: #selector(DetailsImageAndTitleView.imageSwipeHandler(_:)))
        swipeLeftGR.direction = .left
        swipeRightGR.direction = .right
        carouselPreview.isUserInteractionEnabled = true
        carouselPreview.addGestureRecognizer(singleTapGR)
        carouselPreview.addGestureRecognizer(swipeLeftGR)
        carouselPreview.addGestureRecognizer(swipeRightGR)
        
        imagesURLArray = delegate!.detailsImageView(imagesStringArrayForProductInView: self)
        let productTitle = delegate!.detailsImageView(titleForProductInView: self)
        let productPrice = delegate!.detailsImageView(priceForProductInView: self)
        
        self.isUserInteractionEnabled = true
        
        titleLabel.text = productTitle
        priceLabel.text = productPrice
        if !imagesURLArray.isEmpty {
            loadImage(url: imagesURLArray.first!)
        }
        
        carouselPreview.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(carouselPreview.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(15)
            make.bottom.right.equalToSuperview().inset(5)
        }
    }
    
    @objc func imageSwipeHandler(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            loadPrevImage()
        }
        
        if sender.direction == .left {
            loadNextImage()
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer?) {
        self.delegate?.carouselImageTapped!()
    }
    
    private func loadImage(url: String) {
        if let anUrl = URL(string: url) {
            if let index = imagesURLArray.index(of: url) {
                currentImageDisplayingIndex = index
            }
            carouselPreview.af_setImage(withURL: anUrl)
        }
    }
    
    private func loadNextImage() {
        if !imagesURLArray.isEmpty {
            if currentImageDisplayingIndex == imagesURLArray.count - 1 {
                return
            }
            if currentImageDisplayingIndex < imagesURLArray.count {
                loadImage(url: imagesURLArray[currentImageDisplayingIndex + 1])
            }
        }
    }
    
    private func loadPrevImage() {
        if !imagesURLArray.isEmpty {
            if currentImageDisplayingIndex == 0 {
                return
            }
            if currentImageDisplayingIndex > 0 {
                loadImage(url: imagesURLArray[currentImageDisplayingIndex - 1])
            }
        }
    }
}
