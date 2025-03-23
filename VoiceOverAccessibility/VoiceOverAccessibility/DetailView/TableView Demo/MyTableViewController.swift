//
//  MyTableViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 23/03/25.
//

import UIKit


class MyTableViewController: IUIViewController,UITableViewDelegate,UITableViewDataSource {
    private let optionSegmentButton : UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Optimzed", "Default"])
        segment.selectedSegmentIndex = 0
        return segment
    }()

    let tableView = UITableView(frame: .zero, style: .grouped)

    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .systemGray6
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Table View"

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        addSubViews()
        setLabelText()
    }

    private func addSubViews(){
        view.addSubview(optionSegmentButton)
        optionSegmentButton.translatesAutoresizingMaskIntoConstraints = false
        optionSegmentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        optionSegmentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        optionSegmentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        optionSegmentButton.addTarget(self, action: #selector(optionSegmentButtonTapped), for: .valueChanged)

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: optionSegmentButton.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10).isActive = true
    }

    fileprivate func setLabelText() {
        if optionSegmentButton.selectedSegmentIndex == 0 {
            descriptionLabel.text = "The entire cell is an Accessibility Element with an appropriate label combining the title, subtitle, and details. The button action is implemented using UIAccessibilityCustomAction."
        }else{
            descriptionLabel.text = "This is UIKit’s default behavior—it groups all UILabels, ignores UIImageViews, and treats UIButton as a separate element."
        }
    }
    
    @objc private func optionSegmentButtonTapped(){
        setLabelText()
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        cell.configure(
            with: "Title \(indexPath.row + 1)",
            subtitle: "Subtitle \(indexPath.row + 1)",
            detail: "Detail \(indexPath.row + 1)",
            icon: UIImage(resource: .profile),
            needAccessibility: optionSegmentButton.selectedSegmentIndex == 0
        )
        return cell
    }
}

