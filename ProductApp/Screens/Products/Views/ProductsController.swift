//
//  ProductsController.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import UIKit
import RxCocoa
import EasyPeasy

final class ProductsController: BaseViewController<ProductsViewModel> {
    
    private lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: collectionViewLayout)
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.loadProducts()
        bindingCollectionViewDataSource()
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
                                   Height(*0.5).like(view))
    }
    
    private func setupCollectionCellSize(){
        let width = (UIScreen.main.bounds.width / 1.5) - 10
        let height = (UIScreen.main.bounds.height * 0.5) - 10
        collectionViewLayout.itemSize = CGSize(width: width , height: height)
    }
    
    func bindingCollectionViewDataSource(){
        viewModel.products.bind(to: collectionView.rx.items){ (collection , index , item) in
            let index = IndexPath(row: index, section: 0)
            let cell = collection.dequeueReusableCell(withReuseIdentifier: String(describing: ProductsCell.self), for: index) as! ProductsCell
            cell.configure(with: item)
            return cell
        }.disposed(by: disposeBag)
    }
}
