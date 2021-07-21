//
//  NetworkService.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/21.
//

import Foundation
import Alamofire

protocol NetworkService {
    typealias networkSuccessResult = (resCode: Int, resResult: Any)
    func post<T: Codable>(_ URL: String, parameters: Parameters?, type: T.Type, completion: @escaping (NetworkResult<networkSuccessResult>) -> Void)
}

extension NetworkService {
    func post<T: Codable>(_ URL: String, parameters: Parameters?, type: T.Type, completion: @escaping (NetworkResult<networkSuccessResult>) -> Void) {
        guard let encodeUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invalid URL")
            return
        }
        AF.request(encodeUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 300).responseData { res in
            switch res.result {
            case .success :
                if let value = res.value {
                    let decoder = JSONDecoder()
                    do {
                        let resCode = res.response?.statusCode ?? 0
                        let data = try decoder.decode(T.self, from: value)
                        completion(.networkSuccess((resCode, data)))
                    } catch(let error) {
                        print("\(encodeUrl) >> Decoding Error: \(error)")
                    }
                }
            case .failure(let err) :
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
