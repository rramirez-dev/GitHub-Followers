//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 12/28/19.
//  Copyright © 2019 Robert Ramirez. All rights reserved.
//

import Foundation
import UIKit

struct Follower: Codable, Hashable {
    var login: String
    var id: Int
    var node_id: String
    var avatar_url: String
    var gravatar_id: String
    var url: String
    var html_url: String
    var followers_url: String
    var following_url: String
    var gists_url: String
    var starred_url: String
    var subscriptions_url: String
    var organizations_url: String
    var repos_url: String
    var events_url: String
    var received_events_url: String
    var type: String
    var site_admin: Bool

    func loadAvatar() -> UIImage {
        var avatarImage = UIImage()

        let avatarUrl = URL(string: avatar_url)!

        if avatarUrl.absoluteString != "" {
            DispatchQueue.global().async {
                do {
                let data = try Data(contentsOf: avatarUrl)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            avatarImage  = image
                        }
                    }
                } catch {
                    print("Cannot load avatar image: \(error)")
                }
            }
        }
        return avatarImage
    }
}
