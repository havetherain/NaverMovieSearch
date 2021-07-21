//
//  UIKit_Extension.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/21.
//

import UIKit
import Kingfisher

extension UIViewController {
    func makeSimpleAlert(title: String, content msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension UIColor {
    convenience init(_ hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hexString).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hexString.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RRGGBB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // RRGGBBAA (32-bit)
            (a, r, g, b) = (int & 0xFF, int >> 24 & 0xFF, int >> 16 & 0xFF, int >> 8 & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIImageView {
    public func imageFromUrl(_ urlString: String?) {
        let defaultImg = UIImage(named: "img_datalab_explain")
        if let url = urlString {
            if url.isEmpty {
                image = defaultImg
            } else {
                kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(.fade(0.5))])
            }
        } else {
            image = defaultImg
        }
    }
}
