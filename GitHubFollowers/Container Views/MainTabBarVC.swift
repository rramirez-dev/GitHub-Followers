//
//  MainTabBarViewController.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 12/26/19.
//  Copyright © 2019 Robert Ramirez. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
