//
//  FollowerInfoViewController.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 1/4/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class FollowerInfoVC: UIViewController {

        private var loginLabel: UILabel!
        private var fullnameLabel: UILabel!
        private var locationLabel: UILabel!
        private var bioTextView: UITextView!
        private var followerDetailsHeaderHStack: UIStackView!
        private var followerBioVStack: UIStackView!
        private var followerInfoVStack: UIStackView!
        private var avatarImageViewContainer: UIView!

        var user: User!
        var avatarImageView: UIImageView!

        override func viewDidLoad() {
            super.viewDidLoad()
            configureFollowerInfoView()
            configureFollowerBioVStack()
            configureFollowerDetailsHeaderHStack()
            configureAvatarImageView()
            configureFollowerInfoVStack()
            configureLoginLabel()
            configureFullnameLabel()
            configureLocationLabel()
            configureBioTextView()
        }

    private func configureFollowerInfoView() {
        view.backgroundColor = .systemBackground
    }

    // MARK: Configure Follower Bio VStack
    private func configureFollowerBioVStack() {
        followerBioVStack = UIStackView()
        followerBioVStack.alignment = .fill
        followerBioVStack.distribution = .fill
        followerBioVStack.spacing = 20
        followerBioVStack.axis = .vertical
        view.addSubview(followerBioVStack)
        setFollowerBioVStackContraints()
    }

    private func setFollowerBioVStackContraints() {
        followerBioVStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            followerBioVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            followerBioVStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            followerBioVStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }

    // MARK: Configure Follower Details HeaderHStack
    private func configureFollowerDetailsHeaderHStack() {
        followerDetailsHeaderHStack = UIStackView()
        followerDetailsHeaderHStack.alignment = .center
        followerDetailsHeaderHStack.distribution = .fill
        followerDetailsHeaderHStack.axis = .horizontal
        followerDetailsHeaderHStack.spacing = 10
        followerBioVStack.addArrangedSubview(followerDetailsHeaderHStack)
    }

    // MARK: Configure Followers Info VStack
    private func configureFollowerInfoVStack() {
        followerInfoVStack = UIStackView()
        followerInfoVStack.alignment = .fill
        followerInfoVStack.distribution = .fill
        followerBioVStack.spacing = 5
        followerInfoVStack.axis = .vertical
        followerDetailsHeaderHStack.addArrangedSubview(followerInfoVStack)
    }

    // MARK: Configure Login Label
    private func configureLoginLabel() {
        loginLabel = UILabel()
        loginLabel.textColor = .label
        loginLabel.text = user.login ?? ""
        loginLabel.font = UIFont.preferredFont(forTextStyle: .headline).withSize(36)
        followerInfoVStack.addArrangedSubview(loginLabel)
    }

    // MARK: Configure Fullname Label
    private func configureFullnameLabel() {
        fullnameLabel = UILabel()
        fullnameLabel.textColor = .systemGray
        fullnameLabel.text = user.name ?? ""
        followerInfoVStack.addArrangedSubview(fullnameLabel)
    }

    // MARK: Configure Location Label
    private func configureLocationLabel() {

        let mapPinEllipseSFSymbol = "mappin.and.ellipse"
        // create an NSMutableAttributedString that we'll append everything to
        let locationAttrStr = NSMutableAttributedString()

        // create our NSTextAttachment
        let mapPinAttachmentImage = NSTextAttachment()
        let smallConfiguration = UIImage.SymbolConfiguration(scale: .small)
        let lightConfiguration = UIImage.SymbolConfiguration(weight: .ultraLight)
        smallConfiguration.applying(lightConfiguration)
        let smallSymbolImage = UIImage(systemName: mapPinEllipseSFSymbol, withConfiguration: smallConfiguration)?.withTintColor(.label, renderingMode: .alwaysOriginal)
        mapPinAttachmentImage.image = smallSymbolImage
        // wrap the attachment in its own attributed string so we can append it
        let mappinWihLocation = NSAttributedString(attachment: mapPinAttachmentImage)

        // add the NSTextAttachment wrapper to our full string.
        if user.location ?? ""  != "" {
            locationAttrStr.append(mappinWihLocation)
            locationAttrStr.append(NSAttributedString(string: " \(user.location!)"))
        } else {
            locationAttrStr.append(NSAttributedString(string: ""))
        }

        locationLabel = UILabel()
        // draw the result in a label
        locationLabel.attributedText = locationAttrStr
        locationLabel.textColor = .systemGray
        followerInfoVStack.addArrangedSubview(locationLabel)
    }

    // MARK: Configure BioTextView
    private func configureBioTextView() {
        bioTextView = UITextView()

        bioTextView.text = user.bio ?? ""
        bioTextView.font = UIFont(name: "ArialMT", size: 16)
        bioTextView.textColor = .systemGray
        bioTextView.isEditable = false
        followerBioVStack.addArrangedSubview(bioTextView)
        setBioTextViewContraints()
    }

    private func setBioTextViewContraints() {
        bioTextView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bioTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    // MARK: Configure AvatarImageView
    private func configureAvatarImageView() {
        avatarImageView = UIImageView()
        guard let avatarURL = URL(string: user.avatar_url!) else { return }

        GitHubAPIService.shared.fetchAvatar(for: avatarURL) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let avatarImage):
                DispatchQueue.main.async {
                    self?.avatarImageView.image = avatarImage
                }
            }
        }
        avatarImageView.backgroundColor = .red
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.masksToBounds = true
        followerDetailsHeaderHStack.addArrangedSubview(avatarImageView)
        setAvatarImageViewContraints()
    }

    private func setAvatarImageViewContraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
