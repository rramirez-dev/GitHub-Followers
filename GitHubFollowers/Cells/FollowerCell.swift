//
//  FollowerCollectionViewCell.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 12/28/19.
//  Copyright © 2019 Robert Ramirez. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let  cellIdentifier = "FollowersCell"
    var loginNameLabel: UILabel = UILabel()
    var avatarImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLoginLabel()
        configureAvatarImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLoginLabel() {

        loginNameLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        loginNameLabel.textAlignment = .center
        loginNameLabel.contentMode = .scaleToFill
        contentView.addSubview(loginNameLabel)
        setLoginLabelContraints()
    }

    private func setLoginLabelContraints() {
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            loginNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            loginNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }

    private func configureAvatarImageView() {
        avatarImageView.backgroundColor = .white
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.layer.masksToBounds = true
        contentView.addSubview(avatarImageView)
        setAvatarImageViewContraints()
    }

    private func setAvatarImageViewContraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImageView.bottomAnchor.constraint(equalTo: loginNameLabel.topAnchor, constant: -5),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
