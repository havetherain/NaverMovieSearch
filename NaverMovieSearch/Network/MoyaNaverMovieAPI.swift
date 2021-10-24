//
//  MovieItemMoya.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/10/23.
//

import Moya

public enum NaverMovies {
    static private var clientId: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "APIKey", ofType: "plist") else {
                fatalError("Couldn't find file 'APIKey.plist'")
            }

            let plist = NSDictionary(contentsOfFile: filePath)

            guard let value = plist?.object(forKey: "NaverMoviewAPIClientID") as? String else {
                fatalError("Couldn't find key 'NaverMoviewAPIClientID' in 'APIKey.plist'")
            }
            return value
        }
    }

    static private var clientSecret: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "APIKey", ofType: "plist") else {
                fatalError("Couldn't find file 'APIKey.plist'")
            }

            let plist = NSDictionary(contentsOfFile: filePath)

            guard let value = plist?.object(forKey: "NaverMoviewAPIClientSecret") as? String else {
                fatalError("Couldn't find key 'NaverMoviewAPIClientSecret' in 'APIKey.plist'")
            }
            return value
        }
    }

    case movies(_ searchWord: String, _ displayCount: Int = 50)
}

extension NaverMovies: TargetType {
    public var baseURL: URL {
        return URL(string: "https://openapi.naver.com")!
    }

    public var path: String {
        switch self {
        case .movies:
            return "/v1/search/movie.json"
        }
    }

    public var method: Method {
        switch self {
        case .movies:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .movies(let searchWord, let displayCount):
            let params: [String: Any] = [
                "query": searchWord,
                "display": displayCount
            ]

            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String : String]? {
        return [
            "X-Naver-Client-Id": NaverMovies.clientId,
            "X-Naver-Client-Secret": NaverMovies.clientSecret
        ]
    }
}
