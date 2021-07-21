//
//  NetworkResult.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/21.
//

import Foundation

enum NetworkResult<T> {
    case networkSuccess(T)
    case networkError((resCode: Int, msg: String))
    case networkFail
}
