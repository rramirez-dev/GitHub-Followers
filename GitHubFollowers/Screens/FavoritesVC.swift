//
//  Favorites.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 12/26/19.
//  Copyright © 2019 Robert Ramirez. All rights reserved.
//

import UIKit

class FavoritesVC: UITableViewController {
    private var favorities: [User]?
    private var datasource: UITableViewDiffableDataSource<Section, User>!
    private let favoritesKey = "favorites"
    private var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.cellIdentifier)
        tableView.delegate = self
        view.backgroundColor = UIColor.systemBackground

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchFavorites()
    }

    private func configureDataSource() {
        datasource = UITableViewDiffableDataSource<Section, User>(tableView: tableView, cellProvider: { (tableView, indexPath, user) -> FavoritesCell? in
            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.cellIdentifier, for: indexPath) as! FavoritesCell
            cell.selectionStyle = .none
            cell.usernameLabel.text = user.login

            guard let avatarURL = URL(string: user.avatar_url!) else {

                return cell
            }

            GitHubAPIService.shared.fetchAvatar(for: avatarURL) { (result) in
                switch result {
                case .success(let avatarImage):
                    DispatchQueue.main.async {
                        cell.avatarImageView.image = avatarImage
                    }
                case .failure(let error):
                    print("Error loading Avatar: \(error)")
                }
            }
            return cell
        })
    }

    private func createSnapshot(from favorites: [User]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections([.main])
        snapshot.appendItems(favorites, toSection: .main)
        datasource.apply(snapshot, animatingDifferences: false, completion: nil)
    }

    private func fetchFavorites() {
        configureDataSource()
        let favoriteUsers = defaults.object(forKey: favoritesKey) as? [[String: String]]
        favorities = [User]()

        if favoriteUsers != nil {
            for userInfo in favoriteUsers! {
                var user = User()
                user.id = Int(userInfo["id"]!)
                user.login = userInfo["login"]!
                user.name = userInfo["name"]!
                user.avatar_url = userInfo["avatar_url"]!
                favorities?.append(user)
            }
        }
        createSnapshot(from: favorities!)
    }
}

extension FavoritesVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let username = favorities![indexPath.row].login!
        let flowLayout = UICollectionViewLayout()
        let followersVC = FollowersVC(collectionViewLayout: flowLayout)
        followersVC.username = username
        navigationController?.pushViewController(followersVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favorities?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            createSnapshot(from: favorities!)
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
