//
//  UIHeaderView.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class UIHeaderView: UIStackView {
    
    let searchQuery = PublishSubject<String?>()
    
    let filtersButtonTapped = PublishSubject<Void>()
    
    private let searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 25
        searchBar.layer.borderColor =  UIColor.detailsColor.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.searchTextField.borderStyle = .none
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private let filtersButton: UIButton = {
        let button = UIButton()
        button.tintColor = .detailsColor
        button.setImage(UIImage(systemName: Images.bars, withConfiguration: UIImage.SymbolConfiguration(pointSize: 45)), for: .normal)
        button.accessibilityIdentifier = "FiltersButton"
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        bindEvents()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        spacing = 5
        addArrangedSubviews(contentOf: [searchBarView, filtersButton])
        setupInputAccessoryView()
    }
    
    private func setupInputAccessoryView(){
        let doneButton = UIBarButtonItem(title: "Done")
        searchBarView.inputAccessoryView = UIToolbar(items: [doneButton])
        doneButton.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.searchBarView.endEditing(true)
        }).disposed(by: disposeBag)
    }
    
    private func bindEvents(){
        searchBarView.rx.searchButtonClicked
        .subscribe(onNext: {[weak self] item in
            self?.searchBarView.endEditing(true)
            self?.searchQuery.on(.next(self?.searchBarView.text))
        }).disposed(by: disposeBag)
        
        filtersButton.rx.tap
        .throttle(RxTimeInterval.milliseconds(750),scheduler: MainScheduler.instance)
        .subscribe(onNext: {[weak self] _ in
            self?.filtersButtonTapped.on(.next(Void()))
        }).disposed(by: disposeBag)
    }
}
