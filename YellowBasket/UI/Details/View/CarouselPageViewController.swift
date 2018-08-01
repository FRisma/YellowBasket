//
//  CarouselPageViewController.swift
//  YellowBasket
//
//  Created by Franco Risma on 31/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import UIKit

class CarouselPageViewController: UIPageViewController, UIPageViewControllerDataSource, SingleImageViewControllerProtocol {
    
    var urlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageDisplayVC = SingleImageViewController(withURL: urlArray.first!) //Forcing to display the first image
        dataSource = self
        imageDisplayVC.delegate = self
        setViewControllers([imageDisplayVC], direction: .forward, animated: true, completion: nil)
    }
    
    //MARK: UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentImageName = (viewController as! SingleImageViewController).imageURL
        let currentIndex = urlArray.index(of: currentImageName!)
        
        if currentIndex! < urlArray.count - 1 {
            let ivc = SingleImageViewController(withURL: urlArray[currentIndex!+1])
            ivc.delegate = self
            return ivc
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentImageName = (viewController as! SingleImageViewController).imageURL
        let currentIndex = urlArray.index(of: currentImageName!)
        
        if currentIndex! > 0 {
            let ivc = SingleImageViewController(withURL: urlArray[currentIndex!-1])
            ivc.delegate = self
            return ivc
        }
        return nil
    }
    
    //MARK: SingleImageViewControllerProtocol
    func imageViewController(didTappedButtonInView: SingleImageViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imageViewController(shouldShowButtonInView: SingleImageViewController) -> Bool {
        return true
    }
    
    func imageViewController(setTitleForButtonInView: SingleImageViewController) -> String {
        return "Close"
    }
}


class SingleImageViewController: UIViewController {
    
    var delegate: SingleImageViewControllerProtocol?
    
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private var theButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(SingleImageViewController.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    var imageURL: String? {
        didSet {
            if let path = URL(string: imageURL!) {
                imageView.af_setImage(withURL: path)
            }
        }
    }
    
    //MARK: Initializer
    init(withURL urlString: String) {
        super.init(nibName: nil, bundle: nil)
        setImage(url: urlString)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let buttonAvailable = self.delegate?.imageViewController(shouldShowButtonInView: self)
        
        if buttonAvailable != nil && buttonAvailable! == true {
            let buttonTitle = self.delegate?.imageViewController(setTitleForButtonInView: self)
            theButton.setTitle(buttonTitle, for: .normal)
            
            view.addSubview(theButton)
            view.bringSubview(toFront: theButton) //Make sure the button is always visible
            
            theButton.snp.makeConstraints { (make) in
                make.top.left.equalToSuperview().inset(15)
            }
        }
    }
    
    //MARK: Internal
    // For calling the didSet observer for imageURL even in the initialization
    private func setImage(url: String) {
        imageURL = url
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        self.delegate?.imageViewController(didTappedButtonInView: self)
    }
}

protocol SingleImageViewControllerProtocol {
    
    func imageViewController(shouldShowButtonInView: SingleImageViewController) -> Bool
    
    func imageViewController(setTitleForButtonInView: SingleImageViewController) -> String
    
    func imageViewController(didTappedButtonInView: SingleImageViewController) -> Void
}
