//
//  ProductDetailsController.swift
//  ProductApp
//
//  Created by Mohannad on 11/08/2023.
//

import UIKit
import EasyPeasy
import RxSwift
import RxCocoa
import Kingfisher

final class ProductDetailsController: BaseViewController<ProductDetailsViewModel> {

    private var photoView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .white
        img.accessibilityIdentifier = "ProductPhoto"
        return img
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Images.back, withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        button.tintColor = .detailsColor
        button.accessibilityIdentifier = "BackButton"
        return button
    }()
    
    private lazy var detailsView: UIProductDetailsView = {
        let view = UIProductDetailsView()
        view.accessibilityIdentifier = "ProductDetailsView"
        view.addGestureRecognizer(panGesture)
        return view
    }()
    
    private var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindingEvents()
        bindingProductInfo()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubviews(contentOf: [photoView, backButton, detailsView])
        setupConstraints()
    }
    
    private func setupConstraints(){
        backButton.easy.layout(Top(15).to(view.safeAreaLayoutGuide, .top), Leading(25), Size(20))
        photoView.easy.layout(Top(20).to(view.safeAreaLayoutGuide , .top),Leading(),Trailing(),
                              Height(*0.5).like(view))
        
        detailsView.easy.layout(Leading(),Trailing(),Bottom(),
                                Height(*0.5).like(view))
    }
    
    
    private func subscribingToPanGesture(){
        panGesture.rx.event.asObservable()
        .subscribe(onNext:{[weak self] pan in
            guard let self = self , pan.state == .ended else {return }
            let translation = pan.translation(in: view)
            UIView.animate(withDuration: 0.2) {
                let newPercent = translation.y < -1 ? 0.92 : 0.5
                self.detailsView.easy.layout(Height(*newPercent).like(self.view))
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
    }
    
    private func bindingProductInfo(){
        let info = viewModel.productDetails.value
        detailsView.configure(with: info)
        guard let url = info.image.asURL() else { return}
        photoView.kf.setImage(with: url)
    }
    
    private func subscribingToBackButton(){
        backButton.rx.tap
        .throttle(RxTimeInterval.milliseconds(750), scheduler: MainScheduler.instance)
        .subscribe(onNext:{[weak self] _ in
            self?.coordinator?.back()
        }).disposed(by: disposeBag)
    }
    
    private func bindingEvents(){
        subscribingToPanGesture()
        subscribingToBackButton()
    }
}
