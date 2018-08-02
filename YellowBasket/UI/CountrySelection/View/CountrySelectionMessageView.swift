//
//  CountrySelectionMessageView.swift
//  YellowBasket
//
//  Created by Franco Risma on 02/08/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class CountrySelectionMessageView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Choose your country"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        backgroundColor = kLaunchScreenTopColor
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
