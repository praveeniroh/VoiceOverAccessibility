//
//  CustomTableViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 29/03/25.
//


import UIKit

final class CustomTableViewController: OptionsViewController {

    private var items: [CustomTableViewItem] = [
        CustomTableViewItem(name: "Crunchy Peanut Butter", isFavorite: false, rating: 3),
        CustomTableViewItem(name: "Smooth Peanut Butter", isFavorite: false, rating: 4),
        CustomTableViewItem(name: "Organic Peanut Butter", isFavorite: false, rating: 5),
        CustomTableViewItem(name: "Chocolate Peanut Butter", isFavorite: false, rating: 2),
        CustomTableViewItem(name: "Smooth Peanut Butter", isFavorite: false, rating: 4),
        CustomTableViewItem(name: "Organic Peanut Butter", isFavorite: false, rating: 5),
    ]

    private lazy var sections: [[CustomTableViewItem]] = [
        items,
        items,
        items
    ]

    private lazy var actionContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        return view
    }()

    private var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        label.text = "benut butter sample"
        label.accessibilityIdentifier = "titleLabel"
        return label
    }()

    private let tableView :UITableView = {
        let tableView =  UITableView(frame: .zero, style: .insetGrouped)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        title = "TableView"
        addSubViews()
    }

    override func addSubViews() {
        super.addSubViews()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshTriggered), for: .valueChanged)
        tableView.refreshControl = refreshControl

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentControlBottomAnchor ?? view.safeAreaLayoutGuide.topAnchor,constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func codeNavigationButtonTapped() {
        let vc = CodeViewController(codeString: #"""
            ///Cell accessibility
            isAccessibilityElement = true
            accessibilityLabel = "\(item.name) , \(item.rating) stars , Marked as \(item.isFavorite ? "favorite" : "not favorite")"
            
            //Sections are converted to header traits
            
            //Be default, trailing swipe actions are converted as custom action 
                func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                    let context = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in
                        self.deleteItem(at: indexPath)
                    })
                    context.image = UIImage(systemName: "trash")
                    let swipe = UISwipeActionsConfiguration(actions: [context])
                    return swipe
                }
            """#)
        navigationController?.pushViewController(vc, animated: true)
    }

    override func optionSegmentButtonTapped() {
        tableView.reloadData()
    }

    ///Default Voice Over's speech not working properly when triggering pull to refresh. Mostly interrupted due to selection of first element annoucement
    @objc private func pullToRefreshTriggered(){
        tableView.refreshControl?.endRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          UIAccessibility.post(notification: .announcement, argument: "Pull To Refresh triggered")
        }
    }
}


//MARK: Tableview delegate  & datasource confirmation
extension CustomTableViewController: UITableViewDataSource, UITableViewDelegate, CustomTableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: sections[indexPath.section][indexPath.row], indexPath: indexPath, needAccessibility: selectedOption == .optimized)
        cell.delegate = self
        return cell
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        ["1", "2", "3"]
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Section \(section)"
        label.accessibilityTraits = .header
        return label
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("item selected")
    }

    func didUpdateFavorite(for cell: CustomTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        sections[indexPath.section][indexPath.row].isFavorite.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func didUpdateRating(for cell: CustomTableViewCell, increase: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        if increase {
            sections[indexPath.section][indexPath.row].rating = min(sections[indexPath.section][indexPath.row].rating + 1, 5)
        } else {
            sections[indexPath.section][indexPath.row].rating = max(sections[indexPath.section][indexPath.row].rating - 1, 0)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let context = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in
            self.deleteItem(at: indexPath)
        })
        context.image = UIImage(systemName: "trash")
        let swipe = UISwipeActionsConfiguration(actions: [context])
        return swipe
    }

    private func deleteItem(at indexPath: IndexPath) {
        sections[indexPath.section].remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
