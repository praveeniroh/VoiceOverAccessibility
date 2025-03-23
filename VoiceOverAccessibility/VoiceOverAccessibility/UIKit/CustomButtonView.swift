//
//  CustomButtonView.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 23/03/25.
//



import UIKit

class CustomButtonView: UIView {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemGray6
        clipsToBounds = true
        layer.cornerRadius = 8
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupView() {
        iconImageView.image = UIImage(resource: .profile)
        iconImageView.tintColor = .systemYellow
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = "Profile"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(iconImageView)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])

        isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)

    }

    @objc private func handleTap() {
        print("CustomButtonView tapped!")
    }
}

#Preview{
    CustomButtonView()
}
