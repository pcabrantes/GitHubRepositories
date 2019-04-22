//
//  GitHubAPI.swift
//  GitHubRepositories
//
//  Created by Paulo Cesar Abrantes on 18/04/19.
//  Copyright © 2019 Paulo Cesar Abrantes. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum GitHubRouter: URLRequestConvertible {
    
    case searchRepositories(Int)
    case userDetails(String)
    
    static let baseURL = "https://api.github.com"
    
    var method: HTTPMethod {
        switch self {
        case .searchRepositories:
            return .get
        case .userDetails:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .searchRepositories:
            return "/search/repositories"
        case .userDetails(let username):
            return "/users/\(username)"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .searchRepositories(let page):
            return ["q": "language:swift", "sort": "stars", "page": page]
        default:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try GitHubRouter.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        
        //print(urlRequest.url?.absoluteString)
        
        return urlRequest
    }
}
