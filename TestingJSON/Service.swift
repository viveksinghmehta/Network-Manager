//
//  Service.swift
//  
//
//  Created by Vivek Singh Mehta on 06/05/19.
//

import Alamofire
import Foundation


enum AppURL: String, CaseIterable {
    
    case users = "https://viveksinghmehta.herokuapp.com/users"
    case download = "asdasdasd"
    case newPAth = "hello"
    
}


enum ApiRouter {
    
    case users
    case download
    case path(paramters: [String: Any])
    case newPath
    
     var method: HTTPMethod {
        switch self {
        case .users:
            return .get
        case .newPath:
            return .get
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .users:
            return AppURL.users.rawValue
        case .download:
            return AppURL.download.rawValue
        default :
            return ""
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .users :
            return nil
        case .path(let parameter):
            return parameter
        default :
           return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .users:
            return JSONEncoding.default
        case .download:
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
