//
//  FiltersController.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit
import EasyPeasy
import RxSwift

final class FiltersController: BaseViewController<FiltersViewModel> {
    
    private let contaitnerView: UIView = {
         let view = UIView()
         view.backgroundColor = .white
         view.layer.cornerRadius = 15
         view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
         return view
    }()
    
    private lazy var contenStack: UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [buttonsStack])
         stack.axis = .vertical
         stack.distribution = .fill
         stack.spacing = 5
         return stack
    }()
    
    private lazy var buttonsStack: UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [resetButton, filtersButton, doneButton])
         stack.axis = .horizontal
         stack.distribution = .equalSpacing
         return stack
    }()
    
    let resetButton: UIButton = {
        return UIButton(type: .custom).setup(text: "Reset", color: .titleColor)
    }()
    
    let filtersButton: UIButton = {
        return UIButton(type: .custom).setup(text: "Filters", color: .titleColor)
    }()
    
    let doneButton: UIButton = {
        return UIButton(type: .custom).setup(text: "Done", color: .bagColor)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .black.withAlphaComponent(0.4)
        view.addSubview(contaitnerView)
        contaitnerView.addSubview(contenStack)
        setupConstraints()
    }
    
    private func setupConstraints(){
        contaitnerView.easy.layout(Bottom(0).to(view, .bottom),
                              Leading(0).to(view),
                              Trailing(0).to(view))
        
        contenStack.easy.layout(Bottom(30),
                              Leading(20),
                              Trailing(20),
                              Top(20))
    }
}
