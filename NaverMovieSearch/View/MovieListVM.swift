//
//  MovieListVM.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/21.
//

import Foundation

final class MovieListVM {
    internal let naverAPI = "https://openapi.naver.com/v1/search/movie.json"
    var movieItems: MovieItems = []
    static var favoriteMovieItems: MovieItems = []

    func getMovieInfos(word: String, completion: @escaping (String?, String?, Bool) -> Void) {
        let parameters = ["query": word, "display": 50] as [String : Any]
        MoiveSearchService.sharedInstance.fetchMovieList(url: naverAPI, params: parameters) { result in
            switch result {
            case .networkSuccess(let movieListResponseData):
                guard let movieListResponseData = movieListResponseData as? NaverMovieAPIResponseData,
                      let movieItems = movieListResponseData.items else {
                    return completion("오류", "데이터 없음", false)
                }

                self.movieItems = movieItems

                completion(nil, nil, true)
            case .networkFail:
                completion("오류", "네트워크 상태를 확인해주세요", false)
            case .networkError((_, let errorMsg)):
                completion("오류", errorMsg, false)
            }
        }
    }
}
