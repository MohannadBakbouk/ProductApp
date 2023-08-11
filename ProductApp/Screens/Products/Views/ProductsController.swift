//
//  ProductsController.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import EasyPeasy

final class ProductsController: BaseViewController<ProductsViewModel> {
    
    lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: collectionViewLayout)
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.refreshControl = refreshControl
        collection.addSubview(refreshControl)
        return collection
    }()
    
    private lazy var collectionViewLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    lazy var collectionDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel> = {
        let dataSouce = RxCollectionViewSectionedReloadDataSource<SectionModel<String, ProductViewData>>(configureCell:{ (_, collection, index, model) in
            let cell = collection.dequeueReusableCell(withReuseIdentifier: String(describing: ProductsCell.self), for: index) as? ProductsCell
            cell?.configure(with: model)
            return cell ?? UICollectionViewCell()
        })
        return dataSouce
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    
    lazy var headerView: UIHeaderView = {
        return UIHeaderView()
    }()
    
    private let titleLabel: UILabel = {
         let lab = UILabel()
         lab.text = "Discovery new places"
         lab.textColor = .titleColor
         lab.font = UIFont.systemFont(ofSize: 30, weight: .regular)
         return lab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.loadProducts()
        bindingToViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCollectionCellSize()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubviews(contentOf: [headerView, titleLabel, collectionView])
        collectionView.register(ProductsCell.self)
        setupConstraints()
    }
    
    private func setupConstraints(){
        headerView.easy.layout(Top(15).to(view.safeAreaLayoutGuide, .top),
                              Leading(15).to(view),
                              Trailing(15).to(view),
                              Height(50))
        
        titleLabel.easy.layout(Top(15).to(headerView, .bottom),
                              Leading(15).to(view),
                              Trailing(15).to(view),
                              Height(50))
        
        collectionView.easy.layout(Top(10).to(titleLabel, .bottom),
                                   Leading(15).to(view),
                                   Trailing(15).to(view),
                                   Height(*0.5).like(view))
    }
    
    private func setupCollectionCellSize(){
        let width = (collectionView.frame.width / 1.5) - 10
        let height = (collectionView.frame.height) - 10
        collectionViewLayout.itemSize = CGSize(width: width , height: height)
    }
    
    private func bindingToViewModel(){
        bindingCollectionViewDataSource()
        bindingRefreshControl()
        bindingIsLoading()
        bindingFiltersButton()
        bindingSelectedFilterParams()
        bindingClearSelectedFilters()
        bindingCollectionSelectItem()
    }
}
