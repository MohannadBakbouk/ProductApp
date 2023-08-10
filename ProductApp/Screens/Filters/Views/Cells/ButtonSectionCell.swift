//
//  ButtonSectionCell.swift
//  ProductApp
//
//  Created by Mohannad on 10/08/2023.
//

import Foundation
import UIKit
import RxCocoa
import EasyPeasy

final class ButtonSectionCell: UITableViewCell {
    
    private let handlerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = .handelColor
        return view
    }()
    
    private lazy var buttonsStack: UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [resetButton, filtersButton, doneButton])
         stack.axis = .horizontal
         stack.distribution = .equalSpacing
         return stack
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .detailsColor
        return view
    }()
    
    private let resetButton: UIButton = {
        return UIButton(type: .custom).setup(text: "Reset", color: .titleColor)
    }()
    
    private let filtersButton: UIButton = {
        return UIButton(type: .custom).setup(text: "Filters", color: .titleColor)
    }()
    
    private let doneButton: UIButton = {
        return UIButton(type: .custom).setup(text: "Done", color: .bagColor)
    }()
    
    var controlEvents: [ControlEvent<Void>]{
        return [resetButton.rx.tap, filtersButton.rx.tap, doneButton.rx.tap]
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews(){
        selectionStyle = .none
        contentView.addSubviews(contentOf: [handlerView, buttonsStack, lineView])
        setupConstraints()
    }
    
    private func setupConstraints(){
        handlerView.easy.layout(Top(0), CenterX(), Width(*0.20).like(contentView), Height(5))
        buttonsStack.easy.layout(Top(10).to(handlerView, .bottom),
                                   Leading(15),
                                   Trailing(15))
        lineView.easy.layout(Leading(), Trailing(), Top(10).to(buttonsStack, .bottom), Bottom(), Height(1))
    }
}
