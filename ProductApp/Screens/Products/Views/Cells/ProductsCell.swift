//
//  ProductsCell.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import UIKit
import EasyPeasy
import Kingfisher

final class ProductsCell: UICollectionViewCell {
    var info: ProductViewData?
    
    private let photoView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.masksToBounds = true
        img.backgroundColor = .white
      return img
    }()
     
    private let nameLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        lab.numberOfLines = 3
        lab.textColor = .titleColor
        return lab
     }()
    
    private let categoryLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .detailsColor
        return lab
     }()
    
    private let ratingView: UIRatingView = {
        let rating = UIRatingView()
        return rating
    }()
    
    private let reviewCountLabel: UILabel = {
         let lab = UILabel()
         lab.text = ""
         lab.textColor = .detailsColor
         lab.font = UIFont.systemFont(ofSize: 16)
         return lab
    }()
    
    private let priceLabel : UILabel = {
         let lab = UILabel()
         lab.text = ""
         lab.font = UIFont.systemFont(ofSize: 16)
         return lab
    }()
    
    private let deliveryLabel : UILabel = {
         let lab = UILabel()
         lab.text = ""
         lab.textColor = .white
         lab.backgroundColor = .bagColor
         lab.textAlignment = .center
         lab.font = UIFont.systemFont(ofSize: 10)
         lab.clipsToBounds = true
         lab.layer.cornerRadius = 10
         return lab
    }()
    
    private let emptyView: UIView = {
         let view = UIView()
         return view
    }()
    
    private lazy var ratingStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [ratingView, reviewCountLabel])
         stack.axis = .horizontal
         stack.spacing = 5
         stack.distribution = .fill
         return stack
    }()
    
    private lazy var mainStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [photoView, nameLabel, infoStack,fooerStack])
         stack.axis = .vertical
         stack.distribution = .equalSpacing
         return stack
    }()
    
    private lazy var infoStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [categoryLabel, ratingStack])
         stack.axis = .vertical
         stack.spacing = 5
         return stack
    }()
    
    private lazy var fooerStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [deliveryLabel, emptyView, priceLabel])
         stack.axis = .horizontal
         stack.spacing = 5
         stack.distribution = .fill
         return stack
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews(){
        contentView.addSubview(mainStack)
        setupViewsConstraints()
        setupBorder()
    }
    
    private func setupViewsConstraints(){
        photoView.easy.layout(Height(*0.6).like(contentView))
        mainStack.easy.layout(Top(10).to(contentView), Leading(10).to(contentView), Trailing(10).to(contentView), Bottom(10).to(contentView))
        deliveryLabel.easy.layout(Width(*0.4).like(mainStack))
        emptyView.easy.layout(Height().like(priceLabel))
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
    
    func configure(with model : ProductViewData){
        nameLabel.text = model.title
        priceLabel.text = "\(model.priceWithUnit)"
        categoryLabel.text = model.category.rawValue
        ratingView.setValueOnlyOneStar(value: model.rating.value)
        reviewCountLabel.text = model.rating.reviewText
        deliveryLabel.text = model.deliveryNote
        info = model
        guard let url = model.image.asURL() else { return}
        photoView.kf.setImage(with: url)
    }
}
