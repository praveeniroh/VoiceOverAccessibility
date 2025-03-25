//
//  UIKitViewController 2.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 22/03/25.
//


import UIKit

final class ElementsTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    private let cellIdentifier = "ElementsTableViewCell"

    private let elements :[UIElement]
    private let framework:Framework
    weak var elementsTableDelegate : (any ElementsTableViewDelegate)?

    init(elements :[UIElement],framework:Framework){
        self.elements = elements
        self.framework = framework
        super.init(frame: .zero, style: .insetGrouped)
        delegate = self
        dataSource = self
        register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = elements[indexPath.row].title(for: framework)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        elementsTableDelegate?.didSelectElement(element: elements[indexPath.row])
    }
}

protocol ElementsTableViewDelegate : AnyObject{
    func didSelectElement(element: UIElement)
}
