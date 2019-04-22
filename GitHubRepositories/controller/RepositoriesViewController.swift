//
//  RepositoriesTableViewController.swift
//  GitHubRepositories
//
//  Created by Paulo Cesar Abrantes on 18/04/19.
//  Copyright © 2019 Paulo Cesar Abrantes. All rights reserved.
//

import UIKit

class RepositoriesTableViewController: UITableViewController {

    let cellId = "repositoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

extension TableView {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
