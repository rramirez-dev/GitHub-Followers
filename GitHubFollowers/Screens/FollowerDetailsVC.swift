//
//  FollowerDetailsViewController.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 1/1/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class FollowerDetailsVC: UIViewController {

    private var doneButton: UIButton!

    //Child View Controllers
    private let repoStatsViewController = RepoStatsVC()
    private let followerStatsViewController = FollowerStatsVC()
    private var followerInfoViewController = FollowerInfoVC()

    private var followerStatsVStack: UIStackView!
    private var followerDetailsVStack: UIStackView!
    private var gitHubDateFooter: UILabel!
    private var user: User!

    var userLoginId = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser(userLoginId: userLoginId)
    }

    // MARK: Configure view
    private func configureView() {
        view.backgroundColor = .systemBackground
    }

    // MARK: Configure doneButton
    private func configureDoneButton() {
        doneButton = UIButton()
        doneButton.backgroundColor = .systemGray6
        doneButton.setTitleColor(.systemGreen, for: .normal)
        doneButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        doneButton.setTitle("Done", for: .normal)
        doneButton.contentHorizontalAlignment = .right
        doneButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        view.addSubview(doneButton)
        setDoneButtonContraints()
    }

    private func setDoneButtonContraints() {
        doneButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            doneButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    // MARK: Configure Followers Info Child View
    private func addChildFollowerInfoViewController() {
        addChild(followerInfoViewController)
        view.addSubview(followerInfoViewController.view)
        followerInfoViewController.didMove(toParent: self)
        configureFollowerInfoViewController()
    }

    private func configureFollowerInfoViewController() {
        followerDetailsVStack.addArrangedSubview(followerInfoViewController.view)
        setFollowerInfoViewControllerContraints()
    }

    private func setFollowerInfoViewControllerContraints() {
        followerInfoViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followerInfoViewController.view.heightAnchor.constraint(equalToConstant: 200)
        ])

    }

    // MARK: Configure Repo Stats Child View
    private func addChildRepoStatsViewController() {
        addChild(repoStatsViewController)
        view.addSubview(repoStatsViewController.view)
        repoStatsViewController.didMove(toParent: self)
        configureRepoStatsViewController()
    }

    private func configureRepoStatsViewController() {
        repoStatsViewController.view.layer.cornerRadius = 15

        followerStatsVStack.addArrangedSubview(repoStatsViewController.view)
        setRepoStatsViewControllerContraints()
    }

    private func setRepoStatsViewControllerContraints() {
        repoStatsViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            repoStatsViewController.view.heightAnchor.constraint(equalToConstant: 130)
        ])
    }

    // MARK: Configure Follower Stats Child View
    private func addChildFollowerStatsViewController() {
        addChild(followerStatsViewController)
        view.addSubview(followerStatsViewController.view)
        followerStatsViewController.didMove(toParent: self)
        configureFollowerStatsViewController()
    }

    private func configureFollowerStatsViewController() {
        followerStatsViewController.view.layer.cornerRadius = 15
        followerStatsVStack.addArrangedSubview(followerStatsViewController.view)
        setFollowerStatsViewControllerContraints()
    }

    private func setFollowerStatsViewControllerContraints() {
        followerStatsViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            followerStatsViewController.view.heightAnchor.constraint(equalToConstant: 130)
        ])
    }

    // MARK: FollowerStats VStack (Public Repos/Gist, Followers/Following)
    private func configureFollowerStatsVStack() {
        followerStatsVStack = UIStackView()
        followerStatsVStack.alignment = .fill
        followerStatsVStack.distribution = .fill
        followerStatsVStack.spacing = 20
        followerStatsVStack.axis = .vertical
        view.addSubview(followerStatsVStack)
        setFollowerStatsVStackContraints()

    }

    private func setFollowerStatsVStackContraints() {
        followerStatsVStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            followerStatsVStack.topAnchor.constraint(equalTo: followerDetailsVStack.bottomAnchor, constant: 0),
            followerStatsVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            followerStatsVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }

    // MARK: Follower Details VStack (login,fullanme,location)
    private func configureFollowerDetailsVStack() {
        followerDetailsVStack = UIStackView()
        followerDetailsVStack.alignment = .fill
        followerDetailsVStack.distribution = .fillProportionally
        followerDetailsVStack.axis = .vertical
        followerDetailsVStack.spacing = 10
        view.addSubview(followerDetailsVStack)
        setFollowerVStackContraints()
    }

    private func setFollowerVStackContraints() {
        followerDetailsVStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            followerDetailsVStack.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 10),
            followerDetailsVStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            followerDetailsVStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

    // MARK: Github footer label
    private func configureGithubFooterLabel() {
        let dateISO8601Formatter = ISO8601DateFormatter()
        let iso8601DateCreated =  dateISO8601Formatter.date(from: user!.created_at!)
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "MMM yyyy"
        let dateCreated = dateFomatter.string(from: iso8601DateCreated!)

        gitHubDateFooter = UILabel()
        gitHubDateFooter.textAlignment = .center
        gitHubDateFooter.textColor = .systemGray
        gitHubDateFooter.text = "GitHub since \(dateCreated)"
        followerStatsVStack.addArrangedSubview(gitHubDateFooter)
    }

    private func fetchUser( userLoginId: String) {
        GitHubAPIService.shared.fetchUser(for: userLoginId) { [weak self] (result) in
            switch result {
            case .failure( let error):
                print(error)
            case .success(let user):
                DispatchQueue.main.async {
                    self?.user = user
                    self?.followerInfoViewController.user = user
                    self?.repoStatsViewController.user = user
                    self!.followerStatsViewController.user = user
                    self!.configureView()
                    self!.configureDoneButton()
                    self!.configureFollowerDetailsVStack()
                    self!.configureFollowerStatsVStack()
                    self!.addChildFollowerInfoViewController()
                    self!.addChildRepoStatsViewController()
                    self!.addChildFollowerStatsViewController()
                    self!.configureGithubFooterLabel()
                }
            }
        }

    }

    @objc private func done() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
