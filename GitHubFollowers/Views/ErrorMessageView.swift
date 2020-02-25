//
//  ErrorMessageView.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 2/18/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class ErrorMessageView: UIView {

    private var errorMessageLabel: UILabel!
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
        setErrorMessageLabelContraints()
    }

    private func configureErrorMessageLabel(message: String) {
        errorMessageLabel = UILabel()
        errorMessageLabel.lineBreakMode = .byWordWrapping
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.font = arialBoldMT
        errorMessageLabel.textColor = .systemGray2
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.text = message
        self.addSubview(errorMessageLabel)
        setErrorMessageLabelContraints()

    }

    private func setErrorMessageLabelContraints() {
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            errorMessageLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            errorMessageLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            errorMessageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        ])
    }
}
