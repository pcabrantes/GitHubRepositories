//
//  MockRepositories.swift
//  GitHubRepositoriesTests
//
//  Created by Paulo Cesar Abrantes on 21/04/19.
//  Copyright © 2019 Paulo Cesar Abrantes. All rights reserved.
//

import Foundation

@testable import GitHubRepositories

struct MockRepositories {
    static var data: [Repository] {
        let repo1 = Repository(repositoryName: "awesome-ios", starCount: "31139", author: "vsouza", profileImage: "https://avatars2.githubusercontent.com/u/484656?v=4")
        
        let repo2 = Repository(repositoryName: "Alamofire", starCount: "30682", author: "Alamofire", profileImage: "https://avatars3.githubusercontent.com/u/7774181?v=4")
        
        let repo3 = Repository(repositoryName: "Charts", starCount: "20738", author: "danielgindi", profileImage: "https://avatars1.githubusercontent.com/u/366926?v=4")
        
        return [repo1, repo2, repo3]
    }
}
