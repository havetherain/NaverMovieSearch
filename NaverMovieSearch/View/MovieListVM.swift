//
//  MovieListVM.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/21.
//

import Foundation
import Moya

final class MovieListVM {
    var movieItems: MovieItems = []
    static var favoriteMovieItems: MovieItems = []

    func getMovies(word: String, displayCount: Int = 50, completion: @escaping (String?, String?, Bool) -> Void) {
        let provider = MoyaProvider<NaverMovies>()
        provider.request(.movies(word, displayCount)) { result in
            switch result {
            case let .success(response):
                do {
                    let naverMovieAPIResponseData = try response.map(NaverMovieAPIResponseData.self)
                    guard let movieItems = naverMovieAPIResponseData.items, movieItems.count > 0 else {
                        return completion("안내", "검색 결과 없음", false)
                    }

                    self.movieItems = movieItems

                    completion(nil, nil, true)
                } catch let error {
                    print(error.localizedDescription)
                    completion("Error", "Data Decode Error", false)
                }
            case let .failure(error):
                print(error.localizedDescription)
                completion("Error", "Network Error", false)
            }
        }
    }
}
