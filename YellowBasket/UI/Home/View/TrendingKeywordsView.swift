//
//  TrendingKewyordsView.swift
//  YellowBasket
//
//  Created by Franco Risma on 02/08/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class TrendingKewyordsView: UIView {

    var delegate: TrendingKeywordsViewDelegate?
    
    private var titles = [String]()
    
    private var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 15
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not supported")
    }
    
    init(withKeys: [String]) {
        super.init(frame: .zero)
        titles = withKeys
        setupView()
    }
    
    private func setupView() {
        backgroundColor = kHomeBackgroundColor
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalTo(self).offset(5)
            }
            make.left.right.bottom.equalToSuperview()
        }
        
        for title in titles {
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.numberOfLines = 1
            button.addTarget(self, action: #selector(self.pressButton(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func pressButton(_ sender: UIButton) {
        if let searchText = sender.titleLabel?.text {
            self.delegate?.tapped(onKeyword: searchText)
        }
    }

}
