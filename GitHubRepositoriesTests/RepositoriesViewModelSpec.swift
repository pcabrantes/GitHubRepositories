//
//  RepositoriesViewModelSpec.swift
//  GitHubRepositoriesTests
//
//  Created by Paulo Cesar Abrantes on 21/04/19.
//  Copyright © 2019 Paulo Cesar Abrantes. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GitHubRepositories

var exp : XCTestExpectation? = nil

class RepositoriesViewModelSpec: QuickSpec {
    
    override func spec() {
        
        var delegate: RepositoriesViewModelDelegate!
        var client: APIMock!
        var viewModel: RepositoriesViewModel!
        
        describe("Given a query") {
            
            context("and query is successful") {
                
                beforeEach {
                    exp = self.expectation(description: "fetch")
                    
                    client = APIMock()
                    delegate = RepositoryDelegate()
                    viewModel = RepositoriesViewModel(delegate: delegate, client: client)
                    
                    client.repositories = MockRepositories.data
                    viewModel.fetchRepositories()
                }
                
                it("should get the correct response") {
                    
                    waitUntil(timeout: 10) { done in
                        expect(viewModel.totalCount).to(equal(3))
                        expect(viewModel.currentCount).to(equal(3))
                        expect(viewModel.repository(at: 0).author).to(equal("vsouza"))
                        expect(viewModel.repository(at: 1).author).to(equal("Alamofire"))
                        expect(viewModel.repository(at: 2).author).to(equal("danielgindi"))
                        done()
                    }
                }
            }
            
            context("and total count is greater than 1000") {
                
                beforeEach {
                    exp = self.expectation(description: "fetch")
                    
                    client = APIMock()
                    delegate = RepositoryDelegate()
                    viewModel = RepositoriesViewModel(delegate: delegate, client: client)
                    
                    client.repositories = MockRepositories.data
                    client.totalCount = 100000000
                    viewModel.fetchRepositories()
                }

                it("should be set to 1000") {
                    waitUntil(timeout: 10) { done in
                        expect(viewModel.totalCount).to(equal(1000))
                        done()
                    }

                }
            }
            
            context("fetch is called 2 times") {

                beforeEach {
                    exp = self.expectation(description: "fetch")

                    client = APIMock()
                    delegate = RepositoryDelegate()
                    viewModel = RepositoriesViewModel(delegate: delegate, client: client)
                    
                    client.repositories = MockRepositories.data
                    
                    viewModel.fetchRepositories()
                    
                    self.waitForExpectations(timeout: 5, handler: nil)
                    exp = self.expectation(description: "fetch2")
                    
                    viewModel.fetchRepositories()
                    
                    self.waitForExpectations(timeout: 5, handler: nil)
                }

                it("should be 6 repositories") {
                    expect(viewModel.currentCount).to(equal(6))
                }
            }
        }
        
        context("fetch is called 2 times and than refresh is called") {
            
            beforeEach {
                exp = self.expectation(description: "fetch")
                
                client = APIMock()
                delegate = RepositoryDelegate()
                viewModel = RepositoriesViewModel(delegate: delegate, client: client)
                
                client.repositories = MockRepositories.data
                
                viewModel.fetchRepositories()
                
                self.waitForExpectations(timeout: 5, handler: nil)
                exp = self.expectation(description: "fetch2")
                
                viewModel.fetchRepositories()
                
                self.waitForExpectations(timeout: 5, handler: nil)
                
                exp = self.expectation(description: "refresh")
                
                viewModel.refreshRepositories()
                
                self.waitForExpectations(timeout: 5, handler: nil)
            }
            
            it("should be 3 repositories") {
                expect(viewModel.currentCount).to(equal(3))
            }
        }
    
        context("fetch fails") {

            beforeEach {
                exp = self.expectation(description: "fetch")
                
                client = APIMock()
                delegate = RepositoryDelegate()
                viewModel = RepositoriesViewModel(delegate: delegate, client: client)
                
                client.error = NSError(domain:"", code:500, userInfo:nil)
                client.repositories = []
                
                viewModel.fetchRepositories()
                
                self.waitForExpectations(timeout: 5, handler: nil)
            }

            it("should be 0 repositories") {
                expect(viewModel.currentCount).to(equal(0))
            }
        }
        
        context("fetch succeeds and than fails") {
            beforeEach {
                exp = self.expectation(description: "fetch")
                
                client = APIMock()
                delegate = RepositoryDelegate()
                viewModel = RepositoriesViewModel(delegate: delegate, client: client)
                client.repositories = MockRepositories.data
                
                viewModel.fetchRepositories()
                
                self.waitForExpectations(timeout: 5, handler: nil)
                
                client.error = NSError(domain:"", code:500, userInfo:nil)
                client.repositories = []
                
                exp = self.expectation(description: "fetch2")
                
                viewModel.fetchRepositories()
                
                self.waitForExpectations(timeout: 5, handler: nil)
            }
            
            it("should be 3 repositories") {
                expect(viewModel.currentCount).to(equal(3))
            }
        }
    }
}

class APIMock: GitHubProtocol {
    
    var repositories: [Repository]? = nil
    var totalCount: Int? = nil
    var error: Error? = nil
    
    func getRepositories(page: Int, completion: @escaping (RepositoryResponse) -> Void) {
        completion(RepositoryResponse(totalCount: totalCount != nil ? totalCount : repositories?.count, error: error, repositories: repositories))
    }
}

class RepositoryDelegate: RepositoriesViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        exp?.fulfill()
    }
    
    func onFetchFailed(with reason: String) {
        exp?.fulfill()
    }
}
