//
//  CustomCell.swift
//  GitHubRepositories
//
//  Created by Paulo Cesar Abrantes on 19/04/19.
//  Copyright © 2019 Paulo Cesar Abrantes. All rights reserved.
//

import Foundation
import UIKit

class RepositoryCell: UITableViewCell {

    let profileImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let repositoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor =  UIColor(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(repositoryLabel)
        containerView.addSubview(nameLabel)
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(containerView)
        
        profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        repositoryLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        repositoryLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        repositoryLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: self.repositoryLabel.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(with repository: Repository?) {
        
        if let repository = repository {
            self.repositoryLabel.text = "\(repository.repositoryName ?? "") (\(repository.starCount ?? "0"))"
            self.nameLabel.text = repository.author
            //self.profileImageView.image = UIImage(
            
        }
    }
}
