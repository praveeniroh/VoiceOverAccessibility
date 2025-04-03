//
//  CustomTableViewDelegate.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 29/03/25.
//


import UIKit

protocol CustomTableViewDelegate: AnyObject {
    func didUpdateFavorite(for cell: CustomTableViewCell)
    func didUpdateRating(for cell: CustomTableViewCell, increase: Bool)
}

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomTableViewCell"

    weak var delegate: CustomTableViewDelegate?

    private let nameLabel = UILabel()

    private let favoriteButton : UIButton = {
        let switchButton = UIButton()
        switchButton.isSelected = false

        switchButton.setImage(UIImage(systemName: "heart"), for: .normal)
        switchButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        return switchButton
    }()

    private let ratingStackView = UIStackView()
    private let ratingLabel :UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = .systemFont(ofSize: 16)
        ratingLabel.textAlignment = .center
        return ratingLabel
    }()

    private let increaseButton = UIButton()
    private let decreaseButton = UIButton()

    private let containerStackView = UIStackView()
    private var isFavorite: Bool = false
    private var needAccessibility = false


    ///
    private lazy var favoriteAccessibilityAction : UIAccessibilityCustomAction = {
        let action = UIAccessibilityCustomAction(name: isFavorite ? "Mark as Unfavorite" : "Mark as Favorite",image: nil, target: self, selector: #selector(favoriteTapped(_:)))
        return action
    }()

    private lazy var increaseRatingACAction : UIAccessibilityCustomAction = {
        let action = UIAccessibilityCustomAction(name: "Increase Rating",image: nil, target: self, selector: #selector(increaseTapped(_:)))
        return action
    }()

    private lazy var decreaseRatingACAction : UIAccessibilityCustomAction = {
        let action = UIAccessibilityCustomAction(name:"Decrease Rating", image:nil,target: self, selector: #selector(decreaseTapped(_:)))
        return action
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)

        favoriteButton.addTarget(self, action: #selector(favoriteBtnTapped), for: .touchUpInside)

        increaseButton.setImage(UIImage(systemName: "plus"), for: .normal)
        increaseButton.addTarget(self, action: #selector(increaseBtnTapped), for: .touchUpInside)

        decreaseButton.setImage(UIImage(systemName: "minus"), for: .normal)
        decreaseButton.addTarget(self, action: #selector(decreaseBtnTapped), for: .touchUpInside)

        // Rating StackView
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 8
        ratingStackView.alignment = .center
        ratingStackView.addArrangedSubview(decreaseButton)
        ratingStackView.addArrangedSubview(ratingLabel)
        ratingStackView.addArrangedSubview(increaseButton)

        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        containerStackView.alignment = .leading
        containerStackView.addArrangedSubview(nameLabel)
        containerStackView.addArrangedSubview(ratingStackView)

        contentView.addSubview(favoriteButton)
        contentView.addSubview(containerStackView)

        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favoriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),

            containerStackView.leadingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 12),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    func configure(with item: CustomTableViewItem,indexPath:IndexPath, needAccessibility : Bool) {

        nameLabel.text = item.name
        favoriteButton.isSelected = item.isFavorite
        ratingLabel.text = "⭐️ \(item.rating)"
        isFavorite = item.isFavorite
        favoriteAccessibilityAction.name = item.isFavorite ? "Unmark as favorite" : "Mark as favorite"
        self.needAccessibility = needAccessibility

        if needAccessibility{
            isAccessibilityElement = true
            accessibilityLabel = "\(item.name) , \(item.rating) stars , Marked as \(item.isFavorite ? "favorite" : "not favorite")"
        }else{
            isAccessibilityElement = false
            accessibilityLabel = nil
        }
    }

    @objc private func favoriteBtnTapped() {
        print("### favoriteTapped")
        delegate?.didUpdateFavorite(for: self)
        resetAccessibilityActions()
    }

    @objc private func increaseBtnTapped() {
        print("### increaseTapped")
        delegate?.didUpdateRating(for: self, increase: true)
        resetAccessibilityActions()
    }

    @objc private func decreaseBtnTapped(){
        print("### decreaseTapped")
        delegate?.didUpdateRating(for: self, increase: false)
        resetAccessibilityActions()
    }

    ///When custom action triggered multiple times, fails to trigger
    ///So, tried to remove custom action and resetting action.
    ///Not working
    private func resetAccessibilityActions(){
        accessibilityCustomActions = nil
        accessibilityCustomActions = [favoriteAccessibilityAction,increaseRatingACAction,decreaseRatingACAction]
    }


    ///Accessibility function should always return a bool.
    ///Without return value, second action will not get triggered
    ///Assumes the first one still execute
    @objc private func favoriteTapped(_ customAction: UIAccessibilityCustomAction) -> Bool {
        favoriteBtnTapped()
        UIAccessibility.post(notification: .announcement, argument: isFavorite ? "Marked as favorite" : "Unmarked as favorite")
        return true
    }

    @objc private func increaseTapped(_ customAction: UIAccessibilityCustomAction) -> Bool {
        increaseBtnTapped()
        UIAccessibility.post(notification: .announcement, argument: "Rating increased")
        return true
    }

    @objc private func decreaseTapped(_ customAction: UIAccessibilityCustomAction) -> Bool {
        decreaseBtnTapped()
        UIAccessibility.post(notification: .announcement, argument: "Rating decreased")
        return true
    }

    ///providing custom action over cell
    override var accessibilityCustomActions: [UIAccessibilityCustomAction]? {
        get{
            if needAccessibility{
                return [favoriteAccessibilityAction,increaseRatingACAction,decreaseRatingACAction]
            }else{
                return nil
            }
        }
        set{
            super.accessibilityCustomActions = newValue
        }
    }
}
