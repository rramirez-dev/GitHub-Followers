//
//  FavoritesDataSource.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 3/8/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import Foundation
import UIKit

class FavoritesDataSource: UITableViewDiffableDataSource<Section, User> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
