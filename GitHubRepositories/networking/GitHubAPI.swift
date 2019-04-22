//
//  GitHubAPI.swift
//  GitHubRepositories
//
//  Created by Paulo Cesar Abrantes on 19/04/19.
//  Copyright © 2019 Paulo Cesar Abrantes. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GitHubAPI {
    
    static func getRepositories(page: Int, completion: @escaping ([Repository]) -> Void) {
    
        Alamofire.request(GitHubRouter.searchRepositories(page)).validate().responseJSON { response in
            guard response.result.isSuccess,
                let value = response.result.value else {
                    print("Error while fetching repositories: \(String(describing: response.result.error))")
                    completion([])
                    return
            }

            var repositories = JSON(value)["items"].array?.map { json in
                Repository(repositoryName: json["name"].stringValue, starCount: json["stargazers_count"].stringValue)
            }
        
            if (repositories == nil) {
                repositories = []
            }

            completion(repositories!)
        }
    }
    
}
