//
//  UIColor.swift
//  ProductApp
//
//  Created by Mohannad on 09/08/2023.
//

import UIKit
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
             var int = UInt64()
             Scanner(string: hex).scanHexInt64(&int)
             let a, r, g, b: UInt64
             switch hex.count {
             case 3: // RGB (12-bit)
                 (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
             case 6: // RGB (24-bit)
                 (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
             case 8: // ARGB (32-bit)
                 (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
             default:
                 (a, r, g, b) = (255, 0, 0, 0)
             }
             self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    static var detailsColor : UIColor {
        return UIColor(hexString: "D8D8D8")
    }
    
    static var titleColor: UIColor{
        return UIColor(hexString: "26315F")
    }
    
    static var bagColor: UIColor{
        return UIColor(hexString: "F93963")
    }
    
    static var handelColor: UIColor{
        return UIColor(hexString: "B6B8C5")
    }
}
