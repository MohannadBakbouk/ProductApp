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

    lazy var headerView: UIHeaderView = {
        return UIHeaderView()
    }()
    
    private lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.refreshControl = refreshControl
        scroll.accessibilityIdentifier = "ScrollViewContainer"
        return scroll
    }()
    
    private var container : UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
         let lab = UILabel()
         lab.text = "Discovery new places"
         lab.textColor = .titleColor
         lab.font = UIFont.systemFont(ofSize: 30, weight: .regular)
         return lab
    }()
    
    lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: collectionViewLayout)
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.accessibilityIdentifier = "ProductsCollection"
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
        return  UIRefreshControl()
    }()
    
    let activityIndicatorView : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.color = .darkGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindingToViewModel()
        viewModel.loadProducts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _ = collectionView.frame == .zero ? collectionView.layoutIfNeeded() : ()
        setupCollectionCellSize()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubviews(contentOf: [headerView,scrollView, activityIndicatorView])
        scrollView.addSubview(container)
        container.addSubviews(contentOf: [titleLabel, collectionView])
        collectionView.register(ProductsCell.self)
        setupConstraints()
    }
    
    private func setupConstraints(){
        headerView.easy.layout(Top(15).to(view.safeAreaLayoutGuide, .top),
                               Leading(15),Trailing(15),
                               Height(50))
        activityIndicatorView.easy.layout(Size(25), Center())
        
        scrollView.easy.layout(Top(15).to(headerView, .bottom),Leading(15),Trailing(15),                                     Height(*0.65).like(view))
        container.easy.layout(Edges(),
                              Width().like(scrollView).with(.required),
                              Height().like(scrollView).with(.low))
        
        titleLabel.easy.layout(Top(15),Leading(),Trailing(), Height(50))
        collectionView.easy.layout(Top(10).to(titleLabel, .bottom), Leading(0),
                                   Trailing(0), Bottom(5))
    }
    
    private func setupCollectionCellSize(){
        let sectionInset = collectionViewLayout.sectionInset
        let width = (collectionView.frame.width / 1.5) - (sectionInset.left + sectionInset.right)
        let height = (collectionView.frame.height) - (sectionInset.top + sectionInset.bottom)
        collectionViewLayout.itemSize = CGSize(width: width , height: height)
    }
    
    private func bindingToViewModel(){
        bindingCollectionViewDataSource()
        bindingRefreshControl()
        bindingIsLoading()
        bindingIsRefreshing()
        bindingFiltersButton()
        bindingSelectedFilterParams()
        bindingClearSelectedFilters()
        bindingCollectionSelectItem()
        bindingErrorMessage()
    }
}
