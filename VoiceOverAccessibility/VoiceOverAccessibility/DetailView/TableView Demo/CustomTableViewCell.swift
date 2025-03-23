//
//  CustomTableViewCell.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 23/03/25.
//


import UIKit

class CustomTableViewCell: UITableViewCell {
    private let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .profile)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()

    private let subtitleLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()

    private let detailLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    private let actionButton :UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()

    private var needAccessibility = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }


    private func setupCell() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(actionButton)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),


            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),


            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            subtitleLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),


            detailLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),


            actionButton.leadingAnchor.constraint(equalTo: detailLabel.trailingAnchor, constant: 8),
            actionButton.centerYAnchor.constraint(equalTo: detailLabel.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            actionButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    @objc private func actionButtonTapped() {
        print("Action button tapped!")
    }

    func configure(with title: String, subtitle: String, detail: String, icon: UIImage?,needAccessibility: Bool) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        detailLabel.text = detail
        iconImageView.image = icon
        self.needAccessibility = needAccessibility
        if needAccessibility{
            isAccessibilityElement = true
            accessibilityLabel = title + "," + subtitle + "," + detail
            let action = UIAccessibilityCustomAction(name: "Send", image: nil, target: self, selector: #selector(actionButtonTapped))
            accessibilityCustomActions = [action]
        }else{
            isAccessibilityElement = false
            accessibilityLabel = nil
            accessibilityCustomActions = nil
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        subtitleLabel.text = nil
        detailLabel.text = nil
        iconImageView.image = nil
        isAccessibilityElement = false
        accessibilityCustomActions = nil
        accessibilityLabel = nil
    }
}
