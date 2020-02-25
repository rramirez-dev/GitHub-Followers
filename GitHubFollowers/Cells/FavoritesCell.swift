//
//  FavoritesCell.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 2/21/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {

    static var cellIdentifier = "favoritesCell"
    private let userDetailsHStack = UIStackView()
    private let arialBoldMT = "Arial-BoldMT"
    private var user = User()
    var avatarImageView = UIImageView()
    var usernameLabel = UILabel()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureuserDetailsHStack()
        configureAvatarImageView()
        configureUsernameLabel()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func configureuserDetailsHStack() {
        userDetailsHStack.alignment = .center
        userDetailsHStack.distribution = .fill
        userDetailsHStack.spacing = 10
        userDetailsHStack.axis = .horizontal
        contentView.addSubview(userDetailsHStack)
        setUserDetailsHStackContraints()
    }

    private func setUserDetailsHStackContraints() {
        userDetailsHStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            userDetailsHStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userDetailsHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            userDetailsHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            userDetailsHStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    private func configureUsernameLabel() {
        usernameLabel.font = UIFont(name: arialBoldMT, size: 24)
        userDetailsHStack.addArrangedSubview(usernameLabel)
    }

    private func configureAvatarImageView() {
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.layer.masksToBounds = true
        userDetailsHStack.addArrangedSubview(avatarImageView)
        setAvatarImageViewContraint()
    }

    private func setAvatarImageViewContraint() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }

}
