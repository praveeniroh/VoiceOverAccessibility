//
//  UIKitViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 22/03/25.
//

import UIKit

class UIKitViewController: IUIViewController {
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
    }
}
