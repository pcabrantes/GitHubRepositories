//
//  RepositoriesViewModel.swift
//  GitHubRepositories
//
//  Created by Paulo Cesar Abrantes on 19/04/19.
//  Copyright © 2019 Paulo Cesar Abrantes. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol RepositoriesViewModelDelegate: class {
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
    
}

final class RepositoriesViewModel {
    
    private weak var delegate: RepositoriesViewModelDelegate?
    private let client: GitHubProtocol
    
    private var repositories: [Repository] = []
    private var nextPage = 1
    private var total = 0
    private var isFetchInProgress = false
    
    init(delegate: RepositoriesViewModelDelegate, client: GitHubProtocol) {
        self.delegate = delegate
        self.client = client
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return repositories.count
    }
    
    var fetchInProgres: Bool {
        return isFetchInProgress
    }
    
    func repository(at index: Int) -> Repository {
        return repositories[index]
    }
    
    func fetchRepositories() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        client.getRepositories(page: nextPage, completion: { response in
            
            guard response.error == nil else {
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: response.error!.localizedDescription)
                    print("Error while fetching repositories: \(String(describing: response.error.debugDescription))")
                }
                return
            }
            
            DispatchQueue.main.async {

                self.total = response.totalCount! <= 1000 ? response.totalCount! : 1000

                self.isFetchInProgress = false
                self.repositories.append(contentsOf: response.repositories!)

                if (self.nextPage > 1) {
                    let indexPathsToReload = self.calculateIndexPathsToReload(from: response.repositories!)
                    self.delegate?.onFetchCompleted(with: indexPathsToReload)
                } else {
                    self.delegate?.onFetchCompleted(with: .none)
                }

                self.nextPage += 1
            }
        })
    }
    
    func refreshRepositories() {
        repositories = []
        nextPage = 1
        total = 0
        isFetchInProgress = false
        fetchRepositories()
    }
    
    private func calculateIndexPathsToReload(from newRepositories: [Repository]) -> [IndexPath] {
        let startIndex = repositories.count - newRepositories.count
        let endIndex = startIndex + newRepositories.count
        return (startIndex..<endIndex).map { IndexPath(row:  $0, section: 0) }
    }
}
