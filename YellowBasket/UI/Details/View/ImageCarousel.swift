//
//  ImageCarousel.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class ImageCarousel {
    
    private let stackView = {
        let sv = UIStackView(frame: .zero)
        sv.axis = .horizontal
    }
    
    private var urlArray: [String]? {
        didSet {
            //imageView.af_setImage(withURL: URL(string: imageURL)!)
        }
    }

    func addImageURL() {
        
    }
}
