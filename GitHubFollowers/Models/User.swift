//
//  User.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 1/2/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import Foundation

struct User: Codable, Hashable {

    var login: String?
    var  id: Int?
    var node_id: String?
    var avatar_url: String?
    var gravatar_id: String?
    var url: String?
    var html_url: String?
    var followers_url: String?
    var  following_url: String?
    var gists_url: String?
    var  starred_url: String?
    var  subscriptions_url: String?
    var  organizations_url: String?
    var  repos_url: String?
    var  events_url: String?
    var  received_events_url: String?
    var  type: String?
    var  site_admin: Bool?
    var  name: String?
    var  company: String?
    var  blog: String?
    var  location: String?
    var  email: String?
    var  hireable: Bool?
    var  bio: String?
    var  public_repos: Int?
    var  public_gists: Int?
    var  followers: Int?
    var  following: Int?
    var  created_at: String?
    var  updated_at: String?

    init() {
        login = nil
        id = nil
        node_id = nil
        avatar_url = nil
        gravatar_id = nil
        url = nil
        html_url = nil
        followers_url = nil
        following_url = nil
        gists_url = nil
        starred_url = nil
        subscriptions_url = nil
        organizations_url = nil
        repos_url = nil
        events_url = nil
        received_events_url = nil
        type = nil
        site_admin = nil
        name = nil
        company = nil
        blog = nil
        location = nil
        email = nil
        hireable = nil
        bio = nil
        public_repos = nil
        public_gists = nil
        followers = nil
        following = nil
        created_at = nil
        updated_at = nil
    }
}
