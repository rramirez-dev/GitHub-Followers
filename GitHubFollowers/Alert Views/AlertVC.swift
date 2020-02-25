//
//  AlertVC.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 2/10/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class AlertVC: UIViewController {

    private var alertPopUpStackView: UIStackView!
    private var alertPopUpView: UIView!
    private var alertTitleLabel: UILabel!
    private var alertMessageLabel: UILabel!
    private var alertButton: UIButton!

    var alertMessage = String()
    var alertTitle = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureAlertPopUpView()
        configureAlertPopUpStackView()
        configureAlertTitleLabel()
        configureAlertMessageLabel()
        configureAlertButton()
    }

    private func configureView() {
        view.backgroundColor =  UIColor.init(white: 0.4, alpha: 0.8)
    }

    private func configureAlertPopUpStackView() {
        alertPopUpStackView = UIStackView()
        alertPopUpStackView.alignment = .fill
        alertPopUpStackView.distribution = .equalSpacing
        alertPopUpStackView.axis = .vertical
        alertPopUpView.addSubview(alertPopUpStackView)
        setAlertPopUpStackViewContraints()
    }

    private func setAlertPopUpStackViewContraints() {
        alertPopUpStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alertPopUpStackView.topAnchor.constraint(equalTo: alertPopUpView.topAnchor, constant: 20),
            alertPopUpStackView.leadingAnchor.constraint(equalTo: alertPopUpView.leadingAnchor, constant: 20),
            alertPopUpStackView.trailingAnchor.constraint(equalTo: alertPopUpView.trailingAnchor, constant: -20),
            alertPopUpStackView.bottomAnchor.constraint(equalTo: alertPopUpView.bottomAnchor, constant: -10)
        ])
    }

    private func configureAlertPopUpView() {
        let traitCollection = view.traitCollection
        alertPopUpView = UIView()
        alertPopUpView.layer.cornerRadius = 15
        traitCollection.performAsCurrent {
            alertPopUpView.layer.borderColor = UIColor.label.cgColor
        }
        alertPopUpView.layer.borderWidth = 2.0
        alertPopUpView.backgroundColor = UIColor.systemBackground
        view.addSubview(alertPopUpView)
        setAlertPopUpViewContraints()
    }

    private func setAlertPopUpViewContraints() {
        alertPopUpView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alertPopUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alertPopUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            alertPopUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            alertPopUpView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configureAlertMessageLabel() {
        alertMessageLabel = UILabel()
        alertTitleLabel.textColor = UIColor.label
        alertMessageLabel.numberOfLines = 0
        alertMessageLabel.text = alertMessage
        alertMessageLabel.textAlignment = .center
        alertPopUpStackView.addArrangedSubview(alertMessageLabel)
    }

    private func configureAlertButton() {
        alertButton = UIButton()
        alertButton.backgroundColor = .systemRed
        alertButton.layer.cornerRadius = 10
        alertButton.setTitle("OK", for: .normal)
        alertPopUpStackView.addArrangedSubview(alertButton)
        alertButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        setAlertButtonContraints()
    }

    private func setAlertButtonContraints() {
        alertButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alertButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureAlertTitleLabel() {
        alertTitleLabel = UILabel()
        alertTitleLabel.textAlignment = .center
        alertTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        alertTitleLabel.text = alertTitle
        alertPopUpStackView.addArrangedSubview(alertTitleLabel)
    }

    @objc private func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
}
