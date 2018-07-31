//
//  CategoryListView.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class CategoryListView: UIView {
    
    private let stackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        return sv
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    var delegate: CategoryListViewDelegate? {
        didSet {
            work()
        }
    }
    
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    //MARK: Public
    public func reloadData() {
        work()
    }
    
    //MARK: Internal
    private func setupView() {
        
        backgroundColor = .clear
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func work() {
        guard let aDelegate = delegate else {
            return
        }
        
        let elements = aDelegate.categoryList(numbersOfElementsInCategoryView: self)
        if elements > 0 {
            for index in 1...elements {
                stackView.addArrangedSubview(aDelegate.categoryList(self, viewForElementAtIndex: index-1))
            }
            
        }
    }
}
