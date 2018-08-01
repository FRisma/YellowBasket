//
//  ItemCollectionViewCell.swift
//  YellowBasket
//
//  Created by Franco Risma on 30/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit
import AlamofireImage

class ItemCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    var imageURL: String {
        didSet {
            if imageURL.count > 0 {
                imageView.af_setImage(withURL: URL(string: imageURL)!)
            } else {
                imageView.image = nil
            }
        }
    }

    override init(frame: CGRect) {
        imageURL = ""
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not available")
    }
    
    //MARK: Internal
    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(contentView).multipliedBy(0.75)
        }

        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.left.right.equalTo(imageView).inset(7)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(2)
            make.left.right.equalTo(priceLabel)
        }
        
        layer.cornerRadius = 7.5
        layer.masksToBounds = true
    }
}
