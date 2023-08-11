//
//  UICollectionView.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit
import EasyPeasy

extension UICollectionView{
    func register(_ cellClass: AnyClass){
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass.self))
    }
    
    func setMessage(_ message : String , icon : String = Images.exclamationmark){
        let view = UIView()
        self.backgroundView = view
        
        let messageLabel = UILabel()
        messageLabel.textAlignment = .center
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 2
        messageLabel.lineBreakMode = .byTruncatingMiddle
        messageLabel.text = message
        view.addSubview(messageLabel)

        let imageView  = UIImageView()
        imageView.image = UIImage(systemName : icon)
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        imageView.easy.layout(Size(50), CenterX(), CenterY())
        
        messageLabel.easy.layout(Height(60), CenterX(), Width(*0.90).like(view),
                                 Top(10).to(imageView, .bottom))
    }
    
    func clearMessage(){
        self.backgroundView = nil
    }
}
