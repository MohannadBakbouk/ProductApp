//
//  UIFiltersView.swift
//  ProductApp
//
//  Created by Mohannad on 10/08/2023.
//

import UIKit
import EasyPeasy
import RxSwift
import RxDataSources

final class UIFiltersView: UIStackView, UIFiltersViewProtocol{
    private var heightConstraint: NSLayoutConstraint?
    private let initHeight: CGFloat = 400.0
    let disposeBag = DisposeBag()
    
    private lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.showsVerticalScrollIndicator = false
        table.allowsMultipleSelection = false
        table.isScrollEnabled = false
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.accessibilityIdentifier = "FiltersTable"
        return table
    }()
    
    private lazy var tableDataSource: RxTableViewSectionedReloadDataSource<FilterSectionModel> = {
        let dataSource = RxTableViewSectionedReloadDataSource<FilterSectionModel>(configureCell:{[weak self] (_, table, index, model) in
            return self?.makeCell(table: table, index: index, model: model) ?? UITableViewCell()
         })
         return dataSource
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
        distribution = .fill
        addArrangedSubview(tableView)
        tableView.register(mutipleCells: [CategorySectionCell.self,SortMethodSectionCell.self,ButtonSectionCell.self])
        setupConstraints()
        bindingFilterTableViewDataSource()
    }
    
    private func setupConstraints(){
        tableView.easy.layout(Bottom(0),Leading(0), Trailing(0))
        heightConstraint =  tableView.easy.layout(Height(initHeight)).first
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Since it is double I have to round to prevent executing it serverl times
        guard let height = heightConstraint, height.constant.rounded() !=  tableView.contentSize.height.rounded()  else {return}
        tableView.layoutIfNeeded()
        height.constant = tableView.contentSize.height
    }

    private func bindingFilterTableViewDataSource(){
         Observable.just([.buttons(items: [.buttonItem]), .catgories(items: [.categoryItem]), .sortMethod(items: [.sortMethodItem])])
        .bind(to: tableView.rx.items(dataSource: tableDataSource))
        .disposed(by: disposeBag)
    }
    
    var resetButtonTapped =  PublishSubject<Void>()
    var filtersButtonTapped =  PublishSubject<Void>()
    var doneButtonTapped =  PublishSubject<Void>()
    var selectedCategory = PublishSubject<Category>()
    var selectedSortMethod = PublishSubject<SortMethod>()
    
    private func makeCell(table: UITableView, index: IndexPath, model: FilterItem) -> UITableViewCell?{
        var cell : UITableViewCell?
        switch model {
            case .buttonItem:
                cell = table.dequeueReusableCell(with: ButtonSectionCell.self, for: index) as? ButtonSectionCell
            case .categoryItem:
                cell = table.dequeueReusableCell(with: CategorySectionCell.self, for: index) as? CategorySectionCell
            case .sortMethodItem:
                cell = table.dequeueReusableCell(with: SortMethodSectionCell.self, for: index) as? SortMethodSectionCell
        }
        subscribingToEventsOf(cell: cell, model: model)
        return cell
    }
    
    
    private func subscribingToEventsOf(cell: UITableViewCell?, model: FilterItem){
        switch model {
        case .buttonItem:
             guard let buttonSectionCell = cell as? ButtonSectionCell else {return}
            // I don't like to repeat that for each button, Introduced an alternative solution using the zip function
            _ =  zip(buttonSectionCell.controlEvents, [resetButtonTapped, filtersButtonTapped, doneButtonTapped])
                .map{[unowned self] event , publisher  in
                    event.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
                   .bind(to: publisher)
                   .disposed(by: self.disposeBag)
                }
        case .categoryItem:
                guard let categoriesCell = cell as? CategorySectionCell else {return}
                categoriesCell.selectedCategory // output
                .bind(to: selectedCategory)
                .disposed(by: disposeBag)
            
                resetButtonTapped.bind(to: categoriesCell.resetSelection) // input
                .disposed(by: disposeBag)
         case .sortMethodItem:
                guard let sortMethodsCell = cell as? SortMethodSectionCell else {return}
                sortMethodsCell.selectedSortMethod // output
                .bind(to: selectedSortMethod)
                .disposed(by: disposeBag)
            
                 resetButtonTapped.bind(to: sortMethodsCell.resetSelection)  // input
                .disposed(by: disposeBag)
        }
    }
}
