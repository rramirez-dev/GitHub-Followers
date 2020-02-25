//
//  FollowerStatsViewController.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 1/8/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class FollowerStatsVC: UIViewController {

    private var vStack: UIStackView!
    private var hStack: UIStackView!
    private var getFollowersButton: UIButton!
    private var followersStatsNumbersViewController = RepoStatsNumbersVC()
    private var followingStatsNumbersViewController = RepoStatsNumbersVC()
    private let person2SFSymbol = "person.2"
    private let suitHeartSFSymbol = "suit.heart"
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5

        configureHStack()
        configureGetFollowersButton()
        addFollowingStatsChildView()
        addFollowersStatsChildView()

    }

    // MARK: Repo Stats Container View
    private func addFollowersStatsChildView() {
        addChild(followersStatsNumbersViewController)
        view.addSubview(followersStatsNumbersViewController.view)
        followersStatsNumbersViewController.didMove(toParent: self)
        configureFollowersStatsChildView()
    }

    private func configureFollowersStatsChildView() {
        let followerStatNumber = String(user.followers!)
        followersStatsNumbersViewController.setRepoStatsNumbers(statName: "Followers", statNumber: followerStatNumber, sfSymbolName: person2SFSymbol)
        hStack.addArrangedSubview(followersStatsNumbersViewController.view)
    }

    // MARK: Follower Stats Container view
    private func addFollowingStatsChildView() {
        addChild(followingStatsNumbersViewController)
        view.addSubview(followingStatsNumbersViewController.view)
        followingStatsNumbersViewController.didMove(toParent: self)
        configureFollowingStatsNumbersViewController()
    }

    private func configureFollowingStatsNumbersViewController() {
        let followingStatNumber = String(user.following!)
        followingStatsNumbersViewController.setRepoStatsNumbers(statName: "Following", statNumber: followingStatNumber, sfSymbolName: suitHeartSFSymbol)
        hStack.addArrangedSubview(followingStatsNumbersViewController.view)
    }

    // MARK: Configure hStack (Repo Stats Number VStack Views)
    private func configureHStack() {
        hStack = UIStackView()
        hStack.alignment = .fill
        hStack.distribution = .equalSpacing
        hStack.axis = .horizontal
        view.addSubview(hStack)
        setHStackContraints()

    }

    private func setHStackContraints() {
        hStack.translatesAutoresizingMaskIntoConstraints = false
        let viewTrailingAnchorContraint = hStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        viewTrailingAnchorContraint.priority = UILayoutPriority.init(rawValue: 750)

        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            hStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            viewTrailingAnchorContraint
        ])
    }

    // MARK: Configure getFollowersButton
    private func configureGetFollowersButton() {
        getFollowersButton = UIButton()
        getFollowersButton.backgroundColor = .systemGreen
        getFollowersButton.layer.cornerRadius = 10
        getFollowersButton.setTitleColor(.white, for: .normal)
        getFollowersButton.setTitle("Get Followers", for: .normal)

        DispatchQueue.main.async {
            self.getFollowersButton.addTarget(self, action: #selector(self.getFollowers), for: .touchUpInside)
        }
        view.addSubview(getFollowersButton)
        setGetFollowersButtonContraints()
    }

    private func setGetFollowersButtonContraints() {
        getFollowersButton.translatesAutoresizingMaskIntoConstraints = false
        let contraint = getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        contraint.priority = UILayoutPriority.init(rawValue: 749)

        NSLayoutConstraint.activate([
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            contraint,
            getFollowersButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func getFollowers() {
        guard let tabVC = self.presentingViewController as? MainTabBarVC else { return }
        let selectedTab = tabVC.selectedIndex
        let selectedNC = tabVC.viewControllers![selectedTab] as? UINavigationController

        for controller in selectedNC!.viewControllers {
            if controller.isKind(of: FollowersVC.self) {
                let followerViewController = controller as? FollowersVC
                followerViewController?.username = user.login!
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
