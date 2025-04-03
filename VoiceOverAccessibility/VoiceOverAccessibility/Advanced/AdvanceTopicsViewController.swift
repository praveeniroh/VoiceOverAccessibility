//
//  AdvanceTopicsViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 23/03/25.
//

import UIKit

final class AdvancedTopicsViewController : IUIViewController{
    let data = AdvancedTopics.allCases
    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    init(){
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Advanced", image: UIImage(systemName: "snowflake"), tag: 3)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Advanced Topics"
        setUpSubviews()
    }

    private func setUpSubviews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension AdvancedTopicsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let datum = data[indexPath.row]
        let vc:UIViewController
        if datum == .activationPoint{
            vc = ActivationPointSampleViewController()
        }else if datum == .tableView{
            vc = CustomTableViewController()
        }else{
            vc = ZigZagLabelsViewController(data: data[indexPath.row])
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
