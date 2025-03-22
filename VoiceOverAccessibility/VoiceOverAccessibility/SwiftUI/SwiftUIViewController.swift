//
//  SwiftUIViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 22/03/25.
//

import UIKit

class SwiftUIViewController : IUIViewController {

    init(){
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "SwiftUI", image: UIImage(systemName: "bubbles.and.sparkles"), selectedImage: UIImage(systemName: "bubbles.and.sparkles.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SwiftUI"

    }
}
