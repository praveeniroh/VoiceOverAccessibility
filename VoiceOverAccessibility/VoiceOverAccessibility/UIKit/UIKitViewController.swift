//
//  UIKitViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 22/03/25.
//

import UIKit

final class UIKitViewController: IUIViewController {
    private let elements : [UIElement] = [.button,.switchElement,.slider,.stepper,.segmentedControl,.pageControl,.textField,.imageView,.label,.textView,.customView]

    private lazy var tableView = ElementsTableView(elements: elements, framework: .UIKit)

    init(){
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "UIKit", image: UIImage(systemName: "bonjour"), tag: 0)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIKit"
        setupSubViews()
        tableView.elementsTableDelegate = self
    }

    private func setupSubViews(){
        setupTableView()
    }

    private func setupTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension UIKitViewController : ElementsTableViewDelegate {
    func didSelectElement(element: UIElement) {
        let vc = DetailViewController(element: element)
        navigationController?.pushViewController(vc, animated: true)
    }
}


#Preview {
    UIKitViewController()
}
