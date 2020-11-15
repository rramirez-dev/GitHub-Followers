//
//  Followers.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 12/26/19.
//  Copyright © 2019 Robert Ramirez. All rights reserved.
//

import UIKit

class FollowersVC: UICollectionViewController {

    private var followers = [Follower]()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    private var page = 1
    private var isMoreDataAvailable = true
    private var loadingIndicator = UIActivityIndicatorView()
    private var searchController: UISearchController!
    private var searchedUser: User!

    var username = String() {
        didSet {
            page = 1
            DispatchQueue.main.async {
                self.followers = [Follower]()
                self.fetchSearchedUserInfo()
                self.fetchFollowers()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoadingIndicator()
        configureCollectionView()
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func configureView() {
        collectionView.backgroundColor = .systemBackground
    }

    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorites))
        definesPresentationContext = true
    }

    private func configureSearchController() {
        searchController =  UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search by username"
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.searchTextField.clearButtonMode = .always
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController

    }

    private func setSearchControllerContraints() {
        searchController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            searchController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            searchController.view.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0)
        ])
    }

    private func configureLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.isHidden = true
        view.addSubview(loadingIndicator)
        setLoadingIndicatorContraints()
    }

    private func setLoadingIndicatorContraints() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func configureCollectionView() {

        let screenWidth = (self.view.frame.width - 5)/3
        let cellSize = CGSize(width: screenWidth, height: screenWidth)
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        flowlayout.itemSize = cellSize
        flowlayout.minimumLineSpacing = 1
        flowlayout.minimumInteritemSpacing = 1

        collectionView.setCollectionViewLayout(flowlayout, animated: true)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.cellIdentifier)
        setCollectionViewContraints()
    }

    private func setCollectionViewContraints() {
        NSLayoutConstraint.activate([
            collectionView.safeAreaLayoutGuide.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.safeAreaLayoutGuide.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            collectionView.safeAreaLayoutGuide.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionView.safeAreaLayoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }

    private func fetchSearchedUserInfo() {
        GitHubAPIService.shared.fetchUser(for: username) { [weak self] (result) in
            switch result {
            case .failure( let error):
                print(" \(self!.username) \(error)")
            case .success(let user):
                DispatchQueue.main.async {
                    self?.searchedUser = user
                }
            }
        }
    }

    private func configureDataSource() {

        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView) { (collectionView, indexPath, follower) -> FollowerCell? in
            // swiftlint:disable force_cast
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.cellIdentifier, for: indexPath) as! FollowerCell
            cell.loginNameLabel.text = follower.login
            let avatarUrl = URL(string: follower.avatar_url)!

            GitHubAPIService.shared.fetchAvatar(for: avatarUrl) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let avatarImage):
                    DispatchQueue.main.async {
                        cell.avatarImageView.image = avatarImage
                    }
                }
            }
            return cell
        }
    }

    private func createSnapshot(from followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        self.followers.append(contentsOf: followers)
        snapshot.appendSections([.main])
        snapshot.appendItems(self.followers, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }

    private func fetchFollowers() {

        loadingIndicator.isHidden = false

        GitHubAPIService.shared.fetchFollowers(for: username, page: page) { [weak self] (result) in
            switch result {
            case .success( let followers):

                if followers.count == 0 {
                    DispatchQueue.main.async {
                        self?.title = ""
                        self?.isMoreDataAvailable = false
                        self?.loadingIndicator.isHidden = true
                    }

                    if self!.page == 1 {
                        DispatchQueue.main.async {
                            let noFollowersView = NoFollowersView(username: self!.username)
                            self?.createSnapshot(from: followers)
                            self?.navigationItem.searchController = nil
                            self?.collectionView.backgroundView = noFollowersView
                        }
                    }
                } else {

                    DispatchQueue.main.async {
                        self?.title = self!.username
                        self?.loadingIndicator.isHidden = true
                        self?.configureNavigationBar()
                        self?.configureSearchController()
                        self?.createSnapshot(from: followers)
                    }
                }

            case .failure(let error):

                switch error {
                case .forbidden:
                    DispatchQueue.main.async {
                        let errorMessageView = MessageView(errorMessage: "403 Forbidden")
                        self?.collectionView.backgroundView = errorMessageView
                    }
                case .notFound:
                    DispatchQueue.main.async {
                        let errorMessageView = MessageView(errorMessage: "404 Not Found")
                        self?.collectionView.backgroundView = errorMessageView
                    }
                case .invalidURL:
                    DispatchQueue.main.async {
                        let errorMessageView = MessageView(errorMessage: "Invalid URL")
                        self?.collectionView.backgroundView = errorMessageView
                    }
                default:
                    DispatchQueue.main.async {
                        self?.createSnapshot(from: [])
                    }
                }
                DispatchQueue.main.async {
                    self?.loadingIndicator.isHidden = true
                    self?.navigationItem.searchController = nil
                    self?.navigationItem.rightBarButtonItem = nil
                }
            }
        }
    }

    @objc private func addToFavorites() {
        let alertVC = AlertVC()
        let defaults = UserDefaults.standard
        let favoritesKey = "favorites"
        let userLogin = self.searchedUser.login ?? ""
        let username = self.searchedUser.name ?? userLogin
        let avatarUrl = self.searchedUser.avatar_url ?? ""
        let userId = self.searchedUser.id ?? -1
        var favorites: [[String: String]]? = defaults.object(forKey: favoritesKey) as? [[String: String]]
        var userInfo = [String: String]()
        var message = ""
        var alertTitle = ""
        var alertButtonColor = UIColor()

        userInfo.updateValue(String(userId), forKey: "id")
        userInfo.updateValue(userLogin, forKey: "login")
        userInfo.updateValue(username, forKey: "name")
        userInfo.updateValue(avatarUrl, forKey: "avatar_url")

        if favorites == nil {
            favorites = [[String: String]]()
        }

        if userAlreadyAddedToFavorites(favorites: favorites!, userInfo: userInfo) {
            alertTitle = "Warning!!"
            alertButtonColor = .systemRed
            message = "\(username) has already been added to favorites"
        } else {
             favorites!.append(userInfo)
             defaults.set(favorites, forKey: favoritesKey)
             alertTitle = "Success!"
             alertButtonColor = .systemGreen
             message = "\(username) has been added to you favorites"
        }

        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.alertTitle = alertTitle
        alertVC.alertMessage = message
        alertVC.alertButtonColor = alertButtonColor
        alertVC.view.layoutIfNeeded()
        present(alertVC, animated: true, completion: nil)
    }

    private func userAlreadyAddedToFavorites(favorites: [[String: String]], userInfo: [String: String]) -> Bool {
        for user in favorites {
            if user.values.contains(userInfo["id"]!) {
                return true
            }
        }
        return false
    }
}

extension FollowersVC {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = dataSource.itemIdentifier(for: indexPath)
        let followerDetailsViewController = FollowerDetailsVC()
        followerDetailsViewController.userLoginId = follower!.login
        navigationController?.present(followerDetailsViewController, animated: true, completion: nil)
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if isMoreDataAvailable {
            page += 1
            fetchFollowers()
        }
    }
}

extension FollowersVC: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let filteredFollowers: [Follower]

        if !text.isEmpty {
            filteredFollowers =  self.followers.filter { $0.login.lowercased().contains(text.lowercased()) }
        } else {
            filteredFollowers = self.followers
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredFollowers)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}
