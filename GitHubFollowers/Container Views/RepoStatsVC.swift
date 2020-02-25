//
//  GitHubRepoStatsViewController.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 1/8/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import SafariServices
import UIKit

class RepoStatsVC: UIViewController {

    private var repoDetailsVStack: UIStackView!
    private var repoStatsHStack: UIStackView!
    private var gitHubProfileButton: UIButton!
    private var repoStatsNumbersViewController = RepoStatsNumbersVC()
    private var gistStatsNumbersViewController = RepoStatsNumbersVC()
    private let folder = "folder"
    private let textJustifyleft = "text.justifyleft"
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        configureRepoDetailsVStack()
        configureRepoStatsHStack()
        configureGitHubProfileButton()
        addChildRepoStatsNumbersViewController()
        addChildFollowerStatsNumbersViewController()
    }

    // MARK: Add Follower Stats Numbers Child View Controller
    private func addChildFollowerStatsNumbersViewController() {
        addChild(gistStatsNumbersViewController)
        view.addSubview(gistStatsNumbersViewController.view)
        gistStatsNumbersViewController.didMove(toParent: self)
        configureFollowerStatsNumbersViewController()
    }

    private func configureFollowerStatsNumbersViewController() {
        let gistStatNumber =  String(user!.public_gists!)
        gistStatsNumbersViewController.setRepoStatsNumbers(statName: "Public Gist", statNumber: gistStatNumber, sfSymbolName: textJustifyleft)
        repoStatsHStack.addArrangedSubview(gistStatsNumbersViewController.view)
    }

    // MARK: Add Repo Stats Numbers Child View Controller
    private func addChildRepoStatsNumbersViewController() {
        addChild(repoStatsNumbersViewController)
        view.addSubview(repoStatsNumbersViewController.view)
        repoStatsNumbersViewController.didMove(toParent: self)
        configureRepoStatsNumbersViewController()
    }

    // MARK: Configure Repo Stats Numbers View Controller
    private func configureRepoStatsNumbersViewController() {

        repoStatsNumbersViewController.setRepoStatsNumbers(statName: "Public Repos", statNumber: String(user!.public_repos!), sfSymbolName: folder)
        repoStatsHStack.addArrangedSubview(repoStatsNumbersViewController.view)
    }

    // MARK: Repo Details VStack (Repo Stats HStack, GitHub Profile Button)
    private func configureRepoDetailsVStack() {
        repoDetailsVStack = UIStackView()
        repoDetailsVStack.alignment = .fill
        repoDetailsVStack.distribution = .fillEqually
        repoDetailsVStack.axis = .vertical
        repoDetailsVStack.spacing = 5
        view.addSubview(repoDetailsVStack)
        setRepoDetailsVStackContraints()
    }

    private func setRepoDetailsVStackContraints() {
        repoDetailsVStack.translatesAutoresizingMaskIntoConstraints = false
        let repoStatsViewTrailingContraint = repoDetailsVStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        repoStatsViewTrailingContraint.priority = UILayoutPriority.init(rawValue: 751)
        let repoStatsViewLeadingContraint = repoDetailsVStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        let repoStatsViewBottomContraint = repoDetailsVStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)

        NSLayoutConstraint.activate([
            repoStatsViewTrailingContraint,
            repoStatsViewLeadingContraint,
            repoStatsViewBottomContraint
        ])
    }

    // MARK: Configure Repo Stats HStack (holds Repo Stats container views )
    private func configureRepoStatsHStack() {
        repoStatsHStack = UIStackView()
        repoStatsHStack.alignment = .fill
        repoStatsHStack.distribution = .equalSpacing
        repoStatsHStack.axis = .horizontal
        repoDetailsVStack.addArrangedSubview(repoStatsHStack)
    }

    // MARK: Setup GitHub Profile Button
    private func configureGitHubProfileButton() {
        let gitHubButtonTitle = "GitHub Profile"
        gitHubProfileButton = UIButton()
        gitHubProfileButton.backgroundColor = .systemPurple
        gitHubProfileButton.layer.cornerRadius = 10
        gitHubProfileButton.setTitle(gitHubButtonTitle, for: .normal)
        gitHubProfileButton.setTitleColor(.white, for: .normal)
        gitHubProfileButton.addTarget(self, action: #selector(getGitHubProfile), for: .touchUpInside)
        repoDetailsVStack.addArrangedSubview(gitHubProfileButton)
        setGitHubProfileButtonContraints()
    }

    private func setGitHubProfileButtonContraints() {
        gitHubProfileButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            gitHubProfileButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: Get GitHub Proile
    @objc private func getGitHubProfile() {
        guard let profileURL = URL(string: user.html_url!) else { return }

        let safariVC = SFSafariViewController(url: profileURL)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true, completion: nil)
    }
}
