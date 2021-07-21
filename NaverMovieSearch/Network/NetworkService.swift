//
//  NetworkService.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/21.
//

import Foundation
import Alamofire

protocol NetworkService {
    typealias networkSuccessResult = (Any)
    func get<T: Codable>(_ URL: String, params: Parameters?, type: T.Type, completion: @escaping (NetworkResult<networkSuccessResult>) -> Void)
}

extension NetworkService {
    func get<T: Codable>(_ URL: String, params: Parameters? = nil, type: T.Type, completion: @escaping (NetworkResult<networkSuccessResult>)->Void) {
        guard let encodeUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("GET Invalid URL")
            return
        }

        let headers : HTTPHeaders = ["X-Naver-Client-Id": clientId, "X-Naver-Client-Secret": clientSecret]

        AF.request(encodeUrl, method: .get, parameters: params, headers: headers).validate(statusCode: 200 ..< 300).responseData { res in
            switch res.result {
            case .success:
                if let value = res.value {
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(T.self, from: value)
                        completion(.networkSuccess(data))
                    } catch(let error) {
                        print("GET \(encodeUrl) >> Decoding Error: \(error)")
                    }
                }
            case .failure(let err):
                if let error = err as NSError?, error.code == -1009 {
                    completion(.networkFail)
                } else {
                    let resCode = res.response?.statusCode ?? 0
                    completion(.networkError((resCode, err.localizedDescription)))
                }
            }
        }
    }
}

extension NetworkService {
    private var clientId: String {
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

    private var clientSecret: String {
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
}
