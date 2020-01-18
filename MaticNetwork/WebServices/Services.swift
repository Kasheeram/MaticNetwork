//
//  Service.swift
//  LetsVentureTask
//
//  Created by kashee kushwaha on 17/01/20.
//  Copyright © 2020 kashee kushwaha. All rights reserved.
//

import Foundation
import Alamofire
import Reachability





enum errorMessages: Error {
    case noInternet
    case someThingWentWrong
    case outOfStock
}


// 1. Get API With No Parameter, if you want to pass parameter then use POST API
struct Service {
    static let shared = Service()
    func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (Swift.Result<T, Error>) -> ()) {
        let reachability = try! Reachability()
        if (reachability.isReachable) {
            AF.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default,headers: nil).validate().responseJSON {
                response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else { return }
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let homeFeed = try decoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(homeFeed))
                        }
                    } catch let jsonError{
                        completion(.failure(jsonError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure(errorMessages.noInternet))
        }
    }
}
