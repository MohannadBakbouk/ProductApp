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
        collection.contentInset.top = 25
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.loadProducts()
        bindindToViewModel()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(ProductsCell.self)
        setupConstraints()
        setupCollectionCellSize()
    }
    
    private func setupConstraints(){
        collectionView.easy.layout(Top(15).to(view.safeAreaLayoutGuide, .top),
                                   Leading(15).to(view),
                                   Trailing(15).to(view),
                                   Height(*0.55).like(view))
    }
    
    private func setupCollectionCellSize(){
        let width = (UIScreen.main.bounds.width / 1.5) - 10
        let height = (UIScreen.main.bounds.height * 0.5) - 10
        collectionViewLayout.itemSize = CGSize(width: width , height: height)
    }
    
    private func bindindToViewModel(){
        bindingCollectionViewDataSource()
        bindingRefreshControl()
        bindingIsLoading()
    }
}
