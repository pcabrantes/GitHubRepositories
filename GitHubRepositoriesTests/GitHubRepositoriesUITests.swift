//
//  GitHubRepositoriesUITests.swift
//  GitHubRepositoriesUITests
//
//  Created by Paulo Cesar Abrantes on 15/04/19.
//  Copyright © 2019 Paulo Cesar Abrantes. All rights reserved.
//

import FBSnapshotTestCase

@testable import GitHubRepositories

class GitHubRepositoriesUITests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }
    
    func testExample() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = RepositoriesViewController()
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: viewController)
        
        FBSnapshotVerifyView(window.rootViewController!.view)
    }

}
