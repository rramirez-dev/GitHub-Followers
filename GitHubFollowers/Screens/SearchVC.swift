//
//  Search.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 12/26/19.
//  Copyright © 2019 Robert Ramirez. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    private let searchTextField = UITextField()
    private let getFollowersButton = UIButton()
    private var gitHubLogo: UIImage!
    private var gitHubLogoImageView = UIImageView()
    private var githubLogoSeachTextFieldStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        configureView()
        configureGitHubLogoSearchTextFieldStackView()
        configureGitHubLogoImageView()
        configureSearchTextField()
        configureGetFollowersBtn()

    }

    private func configureView() {
        view.backgroundColor = .systemBackground
    }

    private func configureGitHubLogoSearchTextFieldStackView() {
        githubLogoSeachTextFieldStackView = UIStackView()
        githubLogoSeachTextFieldStackView.axis = .vertical
        githubLogoSeachTextFieldStackView.distribution = .fill
        githubLogoSeachTextFieldStackView.spacing = 40

        view.addSubview(githubLogoSeachTextFieldStackView)

        setGitHubLogoSearchTextFieldStackViewContraints()
    }

    private func setGitHubLogoSearchTextFieldStackViewContraints() {
        githubLogoSeachTextFieldStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
        githubLogoSeachTextFieldStackView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
        githubLogoSeachTextFieldStackView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        githubLogoSeachTextFieldStackView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])

    }

    private func configureGitHubLogoImageView() {
        gitHubLogo = UIImage(named: "GitHubLogo")
        gitHubLogoImageView = UIImageView(image: gitHubLogo)
        gitHubLogoImageView.contentMode = .scaleAspectFit
        githubLogoSeachTextFieldStackView.addArrangedSubview(gitHubLogoImageView)
        setGitHubLogoImageViewContraints()
    }

    private func setGitHubLogoImageViewContraints() {

        gitHubLogoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            gitHubLogoImageView.topAnchor.constraint(equalTo: githubLogoSeachTextFieldStackView.topAnchor, constant: 0),
            gitHubLogoImageView.leadingAnchor.constraint(equalTo: githubLogoSeachTextFieldStackView.leadingAnchor, constant: 0),
            gitHubLogoImageView.trailingAnchor.constraint(equalTo: githubLogoSeachTextFieldStackView.trailingAnchor, constant: 0),
            gitHubLogoImageView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.5)
        ])
    }

    private func configureSearchTextField() {
        searchTextField.layer.cornerRadius = 10
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.systemGray2.cgColor
        searchTextField.textAlignment = .center
        searchTextField.placeholder = "Enter Username"
        searchTextField.keyboardType = .default
        searchTextField.returnKeyType = .done
        searchTextField.clearButtonMode = .whileEditing
        githubLogoSeachTextFieldStackView.addArrangedSubview(searchTextField)
        setSearchTextFieldContraints()
    }

    private func setSearchTextFieldContraints() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureGetFollowersBtn() {
        getFollowersButton.backgroundColor = .systemGreen
        getFollowersButton.layer.cornerRadius = 10
        getFollowersButton.setTitleColor(.white, for: .normal)
        getFollowersButton.setTitle("Get Followers", for: .normal)

        getFollowersButton.addTarget(self, action: #selector(fetchFollowers), for: .touchUpInside)
        view.addSubview(getFollowersButton)
        setGetFollowersButtonContraints()
    }

   private func setGetFollowersButtonContraints() {
        getFollowersButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getFollowersButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func fetchFollowers() {
        let flowLayout = UICollectionViewLayout()
        let followersVC = FollowersVC(collectionViewLayout: flowLayout)

//        if let username = searchTextField.text {
//
//            followersVC.username = username.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//            searchTextField.text = ""
//        } else {
//            followersVC.username = ""
//        }

        if searchTextField.text == "" {
            let alertVC = AlertVC()
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.alertTitle = "Warning"
            alertVC.alertMessage = "You must enter a username."
            present(alertVC, animated: true, completion: nil)
        } else {
            let username = searchTextField.text!
            followersVC.username = username.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            navigationController?.pushViewController(followersVC, animated: true)
        }
    }

    @objc func dismissKeyboard() {
        if searchTextField.isFirstResponder {
            print("Tapped")
            view.endEditing(true)
        }
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        self.view.isUserInteractionEnabled = true
    }
}
