//
//  GradientButton.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/23.
//

import UIKit

class GradientButton: UIButton {
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = bounds
        l.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1.0, y: 0.5)
        l.locations = [0.0, 0.2]
        layer.insertSublayer(l, at: 0)
        return l
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
