//
//  Service.swift
//  Created by Vivek Singh Mehta on 06/05/19.
//  This file is created to be used freely and can be modified.

import Alamofire
import Foundation


struct AppURLs {
    static let baseURl = "https://viveksinghmehta.herokuapp.com/"
}


enum AppURL: String, CaseIterable {
    
    case users = "users"
    case download = "asdasdasd"
    case newPath = "hello"
    case query = "queryParameters"
    
}


enum ApiRouter {
    
    case users
    case download
    case path(paramters: [String: Any])
    case query(parameters: [String: Any])
    
     var method: HTTPMethod {
        switch self {
        case .users:
            return .get
        case .query:
            return .get
        case .download:
            return .get
        case .path:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .users:
            return AppURLs.baseURl + AppURL.users.rawValue
        case .download:
            return AppURL.download.rawValue
        case .query:
            return AppURLs.baseURl + AppURL.query.rawValue
        case .path:
            return AppURLs.baseURl + AppURL.path.rawValue
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .users :
            return nil
        case .path(let parameter):
            return parameter
        case .query(let paramters):
            return paramters
        case .download:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .users:
            return JSONEncoding.default
        case .download:
            return URLEncoding.default
        case .query:
            return URLEncoding.default
        default:
          return JSONEncoding.default
        }
    }
    
    
}

class Service {
    
    
    static let shared = Service()
    
    func networkRequest<T: Codable>(router: ApiRouter, completion: @escaping( Swift.Result<T, Error> ) -> Void) {
        Alamofire.request(router.path, method: router.method, parameters: router.parameters, encoding: JSONEncoding.default, headers: nil).responseData { (response) in
            switch response.result {
            case .success(let jsonData):
                    let decoder = JSONDecoder()
                    do {
                        let value = try decoder.decode(T.self, from: jsonData)
                        completion(.success(value))
                    } catch let error {
                        print(error.localizedDescription)
                    }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
