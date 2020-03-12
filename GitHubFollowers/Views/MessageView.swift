//
//  ErrorMessageView.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 2/18/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class MessageView: UIView {

    private var messageLabel: UILabel!
    private let arialBoldMT =  UIFont(name: "Arial-BoldMT", size: 20)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .systemBackground
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(errorMessage: String) {
        super.init(frame: CGRect.zero)
        configureErrorMessageLabel(message: errorMessage)
        setMessageLabelContraints()
    }

    private func configureErrorMessageLabel(message: String) {
        messageLabel = UILabel()
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 0
        messageLabel.font = arialBoldMT
        messageLabel.textColor = .systemGray2
        messageLabel.textAlignment = .center
        messageLabel.text = message
        self.addSubview(messageLabel)
        setMessageLabelContraints()

    }

    private func setMessageLabelContraints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        ])
    }
}
