//
//  SplashController.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import UIKit
import EasyPeasy

final class SplashController: UIViewController {
    
    weak var coordinator : MainCoordinator?
    
    private var inidicatorView:  UIActivityIndicatorView = {
        let item = UIActivityIndicatorView()
        item.tintColor = .darkGray
        item.style = .large
        item.accessibilityIdentifier = "InidicatorView"
        return item
    }()
    
    private var slugLabel : UILabel = {
        let lab = UILabel()
        lab.text = App.name
        lab.textColor = .darkGray
        lab.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        lab.accessibilityIdentifier = "SlugLabel"
        return lab
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        routeToNextScreen()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubviews(contentOf: [slugLabel , inidicatorView])
        setupConstrains()
    }
    
    private func setupConstrains(){
        slugLabel.easy.layout(CenterX(), CenterY(-50))
        inidicatorView.easy.layout(CenterX(), Bottom(50).to(view.safeAreaLayoutGuide, .bottom))
    }
    
    private func routeToNextScreen()  {
        inidicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.coordinator?.showProducts()
        }
    }
}
