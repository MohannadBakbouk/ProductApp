//
//  CategoryItemCell.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit
import EasyPeasy
import RxSwift

final class CategoryItemCell: UICollectionViewCell {
    
    private let nameLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = .detailsColor
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override var isSelected: Bool {
        didSet {
            let color: UIColor = isSelected ? .bagColor : .detailsColor
            contentView.layer.borderColor = color.cgColor
            nameLabel.textColor = color
        }
    }
    
    private func setupViews(){
        contentView.addSubview(nameLabel)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        contentView.layer.borderColor = UIColor.detailsColor.cgColor
        contentView.layer.borderWidth = 1
        setupViewsConstraints()
    }
    
    private func setupViewsConstraints(){
        nameLabel.easy.layout(Leading(10).to(contentView),
                              Trailing(10).to(contentView),
                              Top(5).to(contentView),
                              Bottom(5).to(contentView))
    }
    
    func configure(with model : Category){
        nameLabel.text = model.rawValue
    }
}
