//
//  AccessibilitySwitchTableViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 25/03/25.
//


import UIKit

class ActivationPointSampleViewController: OptionsViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let items = ["Wi-Fi", "Bluetooth", "Airplane Mode", "Dark Mode"]

    private var descriptionLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .systemGray2
        label.backgroundColor = .clear
        label.text = "When a user activates an element with a double tap, we can determine which item should be triggered. This example demonstrates activating a UISwitch by double-tapping on a UITableViewCell."
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Activation Point"
        view.backgroundColor = .systemGray5

        addSubviews()
    }

    private func addSubviews() {
        super.addSubViews()

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.backgroundColor = .systemGray5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: "switchCell")
        
        tableView.topAnchor.constraint(equalTo: segmentControlBottomAnchor ?? view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }

    @objc override func optionSegmentButtonTapped(){
        tableView.reloadData()
    }

    @objc override func codeNavigationButtonTapped() {
        navigationController?.pushViewController(CodeViewController(codeString: AdvancedTopics.activationPoint.code), animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as? SwitchTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(title: items[indexPath.row], needAccessibility: selectedOption == .optimized ? true : false)
        return cell
    }
}

class SwitchTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let toggleSwitch = UISwitch()

    private var needAccessibility = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureAccessibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(titleLabel)
        contentView.addSubview(toggleSwitch)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        toggleSwitch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.bounds.width - 16).isActive = true
        toggleSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        toggleSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16).isActive = true

        toggleSwitch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
    }
    
    func configure(title: String,needAccessibility: Bool) {
        titleLabel.text = title
        self.needAccessibility = needAccessibility
        configureAccessibility()
    }

    override func prepareForReuse() {
        toggleSwitch.isOn = false
        titleLabel.text = nil
    }

    @objc private func switchToggled() {
        configureAccessibility()
    }

    override var accessibilityActivationPoint: CGPoint {
        get {
            if needAccessibility{
                return convert(toggleSwitch.center, to: nil)
            }else{
                return super.accessibilityActivationPoint
            }
        }
        set{
            super.accessibilityActivationPoint = newValue
        }
    }

    private func configureAccessibility() {
        if needAccessibility{
            isAccessibilityElement = true
            accessibilityLabel = titleLabel.text
            accessibilityTraits = .toggleButton

            accessibilityValue = toggleSwitch.accessibilityValue
        }else{
            isAccessibilityElement = false
        }
    }
}
