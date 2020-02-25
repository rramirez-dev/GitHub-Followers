//
//  NoFollowersView.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 1/28/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class NoFollowersView: UIView {

    private var noFollowersLabel: UILabel!
    private var usernameLabel: UILabel!
    private var username = String()
    private let arialBoldMT =  UIFont(name: "Arial-BoldMT", size: 20)

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.backgroundColor = .systemBackground
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(username: String) {
        super.init(frame: CGRect.zero)
        self.username = username
        configureUsernameLabel()
        configureNoFollowersLabel()
    }
    private func configureUsernameLabel() {
        usernameLabel = UILabel()
        usernameLabel.font = arialBoldMT
        usernameLabel.textColor = .label
        usernameLabel.text = username
        self.addSubview(usernameLabel)
        setUsernameLabelContraints()
    }

    private func setUsernameLabelContraints() {
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            usernameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            usernameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

    private func configureNoFollowersLabel() {
        noFollowersLabel = UILabel()
        noFollowersLabel.lineBreakMode = .byWordWrapping
        noFollowersLabel.numberOfLines = 0
        noFollowersLabel.textAlignment = .center
        noFollowersLabel.textColor = .systemGray2
        noFollowersLabel.font = arialBoldMT
        noFollowersLabel.text = "This user does not have any followers.😞"
        self.addSubview(noFollowersLabel)
        setNoFollowersLabelContraints()
    }

    private func setNoFollowersLabelContraints() {
        noFollowersLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            noFollowersLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            noFollowersLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            noFollowersLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        ])
    }
}
