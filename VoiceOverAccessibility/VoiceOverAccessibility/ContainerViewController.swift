//
//  ViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 20/03/25.
//

import UIKit

class ContainerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemMint

        viewControllers = [
            INavigationController(rootViewController: UIKitViewController()),
            INavigationController(rootViewController: SwiftUIViewController())
        ]

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }


}

