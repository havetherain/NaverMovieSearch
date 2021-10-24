//
//  MovieItemVO.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/21.
//

import Foundation

struct NaverMovieAPIResponseData: Codable {
    let display: Int?
    let items: MovieItems?

    enum CodingKeys: String, CodingKey {
        case display, items
    }
}

class MovieItemVO: Codable {
    let title: String?
    let link: String?
    let image: String?
    let director: String?
    let actor: String?
    let userRating: String?
    
    var favorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case title, link, image, director, actor, userRating
    }
}

typealias MovieItems = [MovieItemVO]
