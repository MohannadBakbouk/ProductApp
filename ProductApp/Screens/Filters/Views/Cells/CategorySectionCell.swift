//
//  CategoriesCell.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit
import EasyPeasy
import RxDataSources
import RxSwift
import RxCocoa

final class CategorySectionCell: UITableViewCell {
    private var heightConstraint: NSLayoutConstraint?
    private let initHeight: CGFloat = 75.0

    let disposeBag = DisposeBag()
    
    private lazy var titleLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = .detailsColor
        lab.text = "Categories".uppercased()
        return lab
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: collectionViewLayout)
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    private lazy var mainStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [titleLabel, collectionView])
         stack.axis = .vertical
         stack.distribution = .fill
         stack.spacing = 10
         return stack
    }()
    
    private lazy var collectionViewLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets()
        layout.minimumLineSpacing = 12
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
    
    lazy var collectionDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel> = {
        let dataSouce = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Category>>(configureCell:{ (_, collection, index, model) in
            let cell = collection.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryItemCell.self), for: index) as? CategoryItemCell
            cell?.configure(with: model)
            return cell ?? UICollectionViewCell()
        })
        return dataSouce
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        bindingCategories()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var selectedCategory: Observable<Category>{
        return collectionView.rx.modelSelected(Category.self).asObservable()
    }
    
    private func setupViews(){
        selectionStyle = .none
        contentView.addSubview(mainStack)
        collectionView.register(CategoryItemCell.self)
        setupConstraints()
    }
    
    private func setupConstraints(){
        mainStack.easy.layout(Top(15),
                                   Leading(15),
                                   Trailing(15),
                                   Bottom())
        heightConstraint = collectionView.easy.layout(Height(initHeight)).first
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let height = heightConstraint, height.constant.rounded() !=  collectionViewLayout.collectionViewContentSize.height.rounded()  else {return}
        collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
        height.constant = collectionViewLayout.collectionViewContentSize.height
    }
    
    private func bindingCategories(){
         Observable.just(Category.allCases)
        .map{[SectionModel(model: "", items: $0)]}
        .bind(to: collectionView.rx.items(dataSource: collectionDataSource))
        .disposed(by: disposeBag)
    }
}
