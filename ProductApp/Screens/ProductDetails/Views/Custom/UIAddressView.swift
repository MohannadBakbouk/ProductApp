//
//  UIAddressView.swift
//  ProductApp
//
//  Created by Mohannad on 11/08/2023.
//

import Foundation
import UIKit
import EasyPeasy

final class UIAddressView: UIStackView{
    
    private lazy var locationStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [addressIconView, addressLabel])
         stack.axis = .horizontal
         stack.spacing = 5
         return stack
    }()
    
    private let addressLabel: UILabel = {
        let lab = UILabel()
        lab.text = App.address // dummy info
        lab.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return lab
    }()
    
    private let addressIconView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: Images.location)
        img.tintColor = .detailsColor
        img.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return img
    }()
    
    private lazy var phoneStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [phoneIconView, phoneLabel])
         stack.axis = .horizontal
         stack.spacing = 5
         return stack
    }()
    
    private let phoneLabel: UILabel = {
        let lab = UILabel()
        lab.text = App.phone
        lab.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return lab
    }()
    
    private let phoneIconView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: Images.phone)
        img.tintColor = .detailsColor
        img.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews(){
        axis = .vertical
        spacing = 10
        addArrangedSubviews(contentOf: [locationStack, phoneStack])
    }
    
    private func setupConstraints(){
        addressIconView.easy.layout(Size(20))
        phoneIconView.easy.layout(Size(20))
    }
}
