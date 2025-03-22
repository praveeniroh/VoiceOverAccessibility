//
//  ElementView.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 22/03/25.
//

import UIKit

protocol ElementViewDelegate : AnyObject {
    func viewCodeTapped()
}

class ElementView<T: UIView>: UIView {
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()

    let divider : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()

    private let element: T

    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    private let viewCodeButton : UIButton = {
        let button = UIButton()
        button.setTitle("View Code", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()

    private let showViewCode : Bool
    weak var delegate : ElementViewDelegate?

    init(title: String, element: T, description: String, showViewCode: Bool) {
        self.element = element
        self.showViewCode = showViewCode
        super.init(frame: .zero)
        titleLabel.text = title
        descriptionLabel.text = description
        setupViews()
        viewCodeButton.isHidden = !showViewCode
        backgroundColor = .systemBackground
        clipsToBounds = true
        layer.cornerRadius = 16
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        viewCodeButton.addTarget(self, action: #selector(viewCodeButtonTapped), for: .touchUpInside)

        addSubview(titleLabel)
        addSubview(divider)
        addSubview(element)
        addSubview(descriptionLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        element.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 0),

            element.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 15),
            element.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            element.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),


            descriptionLabel.topAnchor.constraint(equalTo: element.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        let center = element.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
        center.priority = .defaultLow
        center.isActive = true

        let width = element.widthAnchor.constraint(greaterThanOrEqualToConstant: 150)
//        width.priority = .defaultLow
        width.isActive = true

        if showViewCode{
            addSubview(viewCodeButton)
            viewCodeButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
            viewCodeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            viewCodeButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 16),
            viewCodeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            viewCodeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            ])
        }else{
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        }
    }

    @objc private func viewCodeButtonTapped() {
        print("Button tapped!")
        delegate?.viewCodeTapped()
    }
}
#Preview{
    let button = UIButton()
    button.setTitle("Send", for: .normal)
    button.backgroundColor = .green
    button.clipsToBounds = true
    button.layer.cornerRadius = 10
    return ElementView(title: "Test", element: button, description: "Hello world Hello world Hello world Hello world Hello world", showViewCode: true)
}
