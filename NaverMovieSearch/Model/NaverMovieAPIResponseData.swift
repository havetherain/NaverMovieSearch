//
//  NaverMovieAPIResponseData.swift
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
