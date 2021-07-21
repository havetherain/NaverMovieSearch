//
//  MovieSearchService.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/21.
//

import Foundation

struct MoiveSearchService: NetworkService {
    static let sharedInstance = MoiveSearchService()

    func fetchMovieList(url: String, params: [String : Any]? = nil, completion: @escaping (NetworkResult<Any>) -> Void) {
        get(url, params: params, type: NaverMovieAPIResponseData.self) { (result) in
            switch result {
            case .networkSuccess(let successResult):
                completion(.networkSuccess(successResult.resResult))
            case .networkError(let errResult):
                completion(.networkError((errResult.resCode, errResult.msg)))
            case .networkFail:
                completion(.networkFail)
            }
        }
    }
}
