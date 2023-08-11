//
//  ProductPhotoCell.swift
//  ProductApp
//
//  Created by Mohannad on 11/08/2023.
//

import Foundation
import UIKit
import EasyPeasy

final class ProductPhotoCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    private func setupViews(){
        contentView.addSubview(imageView)
        setupBorder()
        setupViewsConstraints()
    }
    
    private func setupBorder(){
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
    
    private func setupViewsConstraints(){
        imageView.easy.layout(Leading(10), Trailing(10) ,Top(10), Bottom(10))
    }
    
    func configure(with photoUrl: URL){
        imageView.kf.setImage(with: photoUrl)
    }
}
