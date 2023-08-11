//
//  UIProductDetailsView.swift
//  ProductApp
//
//  Created by Mohannad on 11/08/2023.
//

import Foundation
import EasyPeasy
import RxSwift
import RxCocoa
import RxDataSources

final class UIProductDetailsView: UIView{
    private let disposeBag = DisposeBag()
    private let titleLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.font = UIFont.boldSystemFont(ofSize: 30)
        lab.numberOfLines = 0
        lab.textColor = .titleColor
        return lab
     }()
    
    private let descriptionLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.font = UIFont.boldSystemFont(ofSize: 18)
        lab.numberOfLines = 0
        return lab
     }()
    
    private let menuLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Menu"
        lab.font = UIFont.boldSystemFont(ofSize: 24)
        lab.textColor = .titleColor
        return lab
     }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: collectionViewLayout)
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    private lazy var collectionViewLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 30, bottom: 5, right: 0)
        layout.minimumLineSpacing = 15
        return layout
    }()
    
    private lazy var collectionDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel> = {
        let dataSouce = RxCollectionViewSectionedReloadDataSource<SectionModel<String, URL>>(configureCell:{ (_, collection, index, model) in
            let cell = collection.dequeueReusableCell(withReuseIdentifier: String(describing: ProductPhotoCell.self), for: index) as? ProductPhotoCell
            cell?.configure(with: model)
            return cell ?? UICollectionViewCell()
        })
        return dataSouce
    }()
    
    private let detailsLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Details"
        lab.font = UIFont.boldSystemFont(ofSize: 24)
        lab.textColor = .titleColor
        return lab
     }()
    
    private let addresView: UIAddressView = {
        return UIAddressView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews(){
        setupShadow()
        addSubviews(contentOf: [titleLabel, descriptionLabel, menuLabel, collectionView, detailsLabel, addresView])
        collectionView.register(ProductPhotoCell.self)
        setupConstraints()
    }
    
    private func setupConstraints(){
        titleLabel.easy.layout(Top(20), Leading(10), Trailing(10))
        descriptionLabel.easy.layout(Top(15).to(titleLabel, .bottom), Leading(10), Trailing(10))
        menuLabel.easy.layout(Top(15).to(descriptionLabel, .bottom), Leading(10), Trailing(10))
        collectionView.easy.layout(Top(5).to(menuLabel, .bottom), Leading(10), Trailing(0),Height(180))
        detailsLabel.easy.layout(Top(15).to(collectionView, .bottom), Leading(10), Trailing(10))
        addresView.easy.layout(Top(5).to(detailsLabel, .bottom), Leading(10), Trailing(10))
    }
    
    private func setupShadow(){
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let sectionInset = collectionViewLayout.sectionInset
        let width = (collectionView.frame.width / 2.5) - (sectionInset.left + sectionInset.right)
        let height = (collectionView.frame.height) - (sectionInset.top + sectionInset.bottom)
        collectionViewLayout.itemSize = CGSize(width: width , height: height)
        collectionViewLayout.invalidateLayout()
    }
    
    func configure(with info: ProductViewData){
        titleLabel.text = info.title
        descriptionLabel.text = info.description
        guard let url = info.image.asURL() else { return}
        let items = Array(repeating: url, count: 10)
        Observable.just([SectionModel(model: "", items: items)])
        .bind(to: collectionView.rx.items(dataSource: collectionDataSource))
        .disposed(by: disposeBag)
    }
}
