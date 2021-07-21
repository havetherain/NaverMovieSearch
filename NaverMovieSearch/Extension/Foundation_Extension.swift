//
//  Foundation_Extension.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/21.
//

import Foundation

extension Optional where Wrapped == String {
    var safelyUnwrapped: String {
        if let self = self {
            return self
        } else {
            return ""
        }
    }
}
