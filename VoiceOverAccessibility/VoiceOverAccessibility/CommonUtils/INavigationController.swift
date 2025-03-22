//
//  INavigationController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 22/03/25.
//

import UIKit

class INavigationController : UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance

        view.backgroundColor = .systemBackground
    }
}
