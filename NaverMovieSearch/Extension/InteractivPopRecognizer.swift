//
//  InteractivPopRecognizer.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/22.
//

import UIKit

class InteractivePopRecognizer: NSObject, UIGestureRecognizerDelegate {
    var navigationController: UINavigationController

    override init() {
        self.navigationController = UINavigationController()
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.navigationController.viewControllers.count > 1 {
            return true
        }
        return false
    }

    public func setInteractiveRecognizer(controller: UINavigationController) {
        self.navigationController = controller
        guard let interactivePopGestureRecognizer = controller.interactivePopGestureRecognizer else { return }
        interactivePopGestureRecognizer.delegate = self
    }
}
