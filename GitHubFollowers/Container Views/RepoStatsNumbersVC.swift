//
//  RepoStatsNumbersViewController.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 1/13/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class RepoStatsNumbersVC: UIViewController {

    private var repoLabelHStack: UIStackView!
    private var repoNumbersLabelVStack: UIStackView!
    private var sfSymbolImageView: UIImageView!
    private var repoLabel: UILabel!
    private var statsNumberLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureRepoNumbersLabelVStack()
        configureRepoLabelHStack()
        configureSFSymbolImageView()
        configureRepoLabel()
        configureStatsNumberLabel()
    }

    // MARK: Configure repoNumbersLabelVStack
    private func configureRepoNumbersLabelVStack() {
        repoNumbersLabelVStack = UIStackView()
        repoNumbersLabelVStack.distribution = .fill
        repoNumbersLabelVStack.alignment = .center
        repoNumbersLabelVStack.spacing = 5
        repoNumbersLabelVStack.axis = .vertical
        view.addSubview(repoNumbersLabelVStack)
        setRepoNumbersLabelVStackContraints()

    }

    private func setRepoNumbersLabelVStackContraints() {
        repoNumbersLabelVStack.translatesAutoresizingMaskIntoConstraints = false
        let repoNumbersLabelVStackLeadingContraint = repoNumbersLabelVStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        let repoNumbersLabelVStackTrailingContraint = repoNumbersLabelVStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        NSLayoutConstraint.activate([
            repoNumbersLabelVStackLeadingContraint,
            repoNumbersLabelVStackTrailingContraint
        ])
    }

    // MARK: Configure Stats Number Label
    private func configureStatsNumberLabel() {
        statsNumberLabel = UILabel()
        statsNumberLabel.font = UIFont.preferredFont(forTextStyle: .headline).withSize(12)
        statsNumberLabel.text = "0"
        repoNumbersLabelVStack.addArrangedSubview(statsNumberLabel)
        setStatsNumberLabelContraints()
    }

    private func setStatsNumberLabelContraints() {
        statsNumberLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([])
    }

    // MARK: Configure SF Symbol Image View
    private func configureSFSymbolImageView() {
        sfSymbolImageView = UIImageView()
        repoLabelHStack.addArrangedSubview(sfSymbolImageView)
        setSFSymbolImageViewContraints()
    }

    private func setSFSymbolImageViewContraints() {
        sfSymbolImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([])
    }

    // MARK: Configure repoLabel
    private func configureRepoLabel() {
        repoLabel = UILabel()
        repoLabel.font = UIFont.preferredFont(forTextStyle: .headline).withSize(12)
        repoLabel.text = ""
        repoLabelHStack.addArrangedSubview(repoLabel)
        setRepoLabelContraints()
    }

    private func setRepoLabelContraints() {
        repoLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([])
    }

    // MARK: Configure Repo Label HStack
    private func configureRepoLabelHStack() {
        repoLabelHStack = UIStackView()
        repoLabelHStack.alignment = .fill
        repoLabelHStack.distribution = .fillProportionally
        repoLabelHStack.axis = .horizontal
        repoLabelHStack.spacing = 5
        repoNumbersLabelVStack.addArrangedSubview(repoLabelHStack)
    }

    func setRepoStatsNumbers(statName: String, statNumber: String, sfSymbolName: String) {
        self.statsNumberLabel.text = statNumber
        self.repoLabel.text = statName
        let sfSymbolSmallConfig = UIImage.SymbolConfiguration(scale: .small)
        let sfSymbolImage = UIImage(systemName: sfSymbolName, withConfiguration: sfSymbolSmallConfig)?.withTintColor(.label, renderingMode: .alwaysOriginal)
        self.sfSymbolImageView.image = sfSymbolImage
    }
}
