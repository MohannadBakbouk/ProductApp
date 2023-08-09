//
//  MainCoordinator.swift
//  ProductApp
//
//  Created by Mohannad on 08/08/2023.
//

import UIKit

final class MainCoordinator: Coordinator{
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigation : UINavigationController) {
        childCoordinators = []
        navigationController = navigation
    }
    
    func start() {
        let splash = SplashController()
        splash.coordinator = self
        pushViewControllerToStack(with: splash)
    }
    
    func showProducts() {
        let productsScreen = ProductsController(viewModel: ProductsViewModel(service: ProductService()), coordinator: self)
        pushViewControllerToStack(with:productsScreen, animated: false, isRoot: true)
    }
    
    func showProductsDetails(){
        
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
}

extension MainCoordinator {
    func pushViewControllerToStack(with value : UIViewController , animated : Bool = true ,  isRoot: Bool = false){
        _ = isRoot ? navigationController.setViewControllers([], animated: false) : ()
        navigationController.pushViewController(value, animated: animated)
    }
}


