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
            configureView()
            configureAvatarImageView()
            configureFollowerInfoVStack()
            configureLoginLabel()
            configureFullnameLabel()
            configureLocationLabel()
            configureBioTextView()
        }

    private func configureView() {
        view.backgroundColor = .systemBackground
    }

    // MARK: Configure Followers Info VStack
    private func configureFollowerInfoVStack() {
        followerInfoVStack = UIStackView()
        followerInfoVStack.alignment = .fill
        followerInfoVStack.distribution = .fill
        followerInfoVStack.axis = .vertical
        view.addSubview(followerInfoVStack)
        setFollowerInfoVStackContraints()
    }

    private func setFollowerInfoVStackContraints() {
        followerInfoVStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            followerInfoVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            followerInfoVStack.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10)
        ])
    }

    // MARK: Configure Login Label
    private func configureLoginLabel() {
        loginLabel = UILabel()
        loginLabel.textColor = .label
        loginLabel.text = user.login ?? ""
        loginLabel.adjustsFontSizeToFitWidth = true
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
        let smallSymbolImage = UIImage(systemName: mapPinEllipseSFSymbol, withConfiguration: smallConfiguration)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
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
        view.addSubview(bioTextView)
        setBioTextViewContraints()
    }

    private func setBioTextViewContraints() {
        bioTextView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bioTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            bioTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            bioTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
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
                    self?.avatarImageView.image = avatarImage.resizeUI(size: CGSize(width: 90, height: 90))
                }
            }
        }

        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.backgroundColor = .red
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.masksToBounds = true
        avatarImageView.setContentHuggingPriority(.init(rawValue: 252), for: .horizontal)
        view.addSubview(avatarImageView)
        setAvatarImageViewContraints()
    }

    private func setAvatarImageViewContraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
}

extension UIImage {
    func resizeUI(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, self.scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))

        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
