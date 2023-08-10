//
//  SortMethodItemCell.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit
import EasyPeasy

final class SortMethodItemCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = .titleColor
        return lab
    }()
    
    private let iconView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: Images.checkMark)
        img.tintColor = .bagColor
        img.isHidden = true
        return img
    }()
    
    private lazy var contenStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [titleLabel, iconView])
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fill
        return stack
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .detailsColor
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let color: UIColor = isSelected ? .bagColor : .titleColor
        iconView.isHidden = !self.isSelected
        titleLabel.textColor = color
    }
    
    private func setupViews(){
        selectionStyle = .none
        contentView.addSubview(contenStack)
        contentView.addSubview(lineView)
        setupViewsConstraints()
    }
    
    private func setupViewsConstraints(){
        contenStack.easy.layout(Leading(15).to(contentView), Trailing(15).to(contentView),
                                Top(10).to(contentView))
        lineView.easy.layout(Leading(), Trailing(), Top(10).to(contenStack, .bottom), Bottom(), Height(1))
        iconView.easy.layout(Size(20))
    }
    
    func configure(with model : SortMethod){
        titleLabel.text = model.rawValue
    }
}
