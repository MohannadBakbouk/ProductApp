//
//  FiltersController.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit
import EasyPeasy
import RxSwift
import RxDataSources

final class FiltersController: BaseViewController<FiltersViewModel> {
    private lazy var contaitnerView: UIView = {
         let view = UIView()
         view.backgroundColor = .white
         view.layer.cornerRadius = 15
         view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
         view.addGestureRecognizer(swipeGesture)
         return view
    }()
    
    private lazy var filtersView: UIFiltersViewProtocol =  {
        return UIFiltersView()
    }()
    
    private let swipeGesture : UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .down
        return gesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindingSwipeGesture()
        bindingFiltersEventsTest()
    }
    
    private func setupViews(){
        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.addSubview(contaitnerView)
        contaitnerView.addSubview(filtersView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        contaitnerView.easy.layout(Bottom(0).to(view, .bottom), Leading(0).to(view), Trailing(0).to(view))
        filtersView.easy.layout(Leading(0),Trailing(0),Top(15), Bottom(50))
    }

    private func bindingSwipeGesture(){
        swipeGesture.rx.event
        .asObservable()
        .subscribe(onNext: {[weak self] gesture in
            self?.coordinator?.dismiss()
        }).disposed(by: disposeBag)
    }
    
    private func bindingFiltersEventsTest(){
        filtersView.restButtonTapped
        .subscribe(onNext:{ event in
            print("restButtonTapped")
        }).disposed(by: disposeBag)
        
        filtersView.filtersButtonTapped
        .subscribe(onNext:{ event in
            print("filtersButtonTapped")
        }).disposed(by: disposeBag)
        
        filtersView.doneButtonTapped
        .subscribe(onNext:{[weak self] _ in
            self?.coordinator?.dismiss()
        }).disposed(by: disposeBag)
        
        filtersView.selectedCategory
        .subscribe(onNext: { event in
          print(event)
        }).disposed(by: disposeBag)
        
        filtersView.selectedSortMethod
        .subscribe(onNext: { event in
          print(event)
        }).disposed(by: disposeBag)
        
    }
}
