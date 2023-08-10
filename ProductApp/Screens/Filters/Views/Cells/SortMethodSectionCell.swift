//
//  SortMethodGroupCell.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit
import EasyPeasy
import RxDataSources
import RxSwift
import RxCocoa

final class SortMethodSectionCell: UITableViewCell {
    private var heightConstraint: NSLayoutConstraint?
    private let initHeight: CGFloat = 170.0
    let disposeBag = DisposeBag()
    var resetSelection = PublishSubject<Void>() //Input
    
    private lazy var titleLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = .detailsColor
        lab.text = "Sort by".uppercased()
        return lab
    }()
    
    private lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.showsVerticalScrollIndicator = false
        table.allowsMultipleSelection = false
        table.isScrollEnabled = false
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        return table
    }()
    
    private lazy var tableDataSource: RxTableViewSectionedReloadDataSource<SectionModel> = {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,SortMethod>>(configureCell:{(_, table, index, model) in
            let cell = table.dequeueReusableCell(withIdentifier: String(describing: SortMethodItemCell.self), for: index) as? SortMethodItemCell
            cell?.configure(with: model)
            return cell ?? UITableViewCell()
        })
         return dataSource
    }()
    
    //Output
    var selectedSortMethod: Observable<SortMethod>{
        return tableView.rx.modelSelected(SortMethod.self).asObservable()
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
        contentView.addSubviews(contentOf: [titleLabel, tableView])
        tableView.register(SortMethodItemCell.self)
        setupConstraints()
        bindingCategories()
        subscribingToResetSelectedItem()
    }

    private func setupConstraints(){
        titleLabel.easy.layout(Top(10), Leading(15), Trailing(15))
        tableView.easy.layout(Top(10).to(titleLabel, .bottom),
                              Leading(),
                              Trailing(),
                              Bottom())
        heightConstraint = tableView.easy.layout(Height(initHeight)).first
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let height = heightConstraint, height.constant.rounded() !=  tableView.contentSize.height.rounded()  else {return}
        tableView.layoutIfNeeded()
        height.constant = tableView.contentSize.height
    }
    
    private func bindingCategories(){
         Observable.just(SortMethod.allCases)
        .map{[SectionModel(model: "", items: $0)]}
        .bind(to: tableView.rx.items(dataSource: tableDataSource))
        .disposed(by: disposeBag)
    }
    
    private func subscribingToResetSelectedItem(){
        resetSelection
        .subscribe(onNext:{[weak self] _ in
            guard let index = self?.tableView.indexPathForSelectedRow else {return}
            self?.tableView.deselectRow(at: index, animated: false)
        }).disposed(by: disposeBag)
    }
}
