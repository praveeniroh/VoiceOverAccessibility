//
//  OptionsViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 28/03/25.
//

import UIKit

enum ComparisionOption : String,CaseIterable{
    case optimized = "Optimized"
    case defaultOption = "Default"
}

class OptionsViewController : UIViewController{
    private lazy var optionSegmentButton : UISegmentedControl = {
        let segment = UISegmentedControl(items: ComparisionOption.allCases.map({$0.rawValue}))
        segment.selectedSegmentIndex = 0
        return segment
    }()

    private lazy var codeNavBarItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Code", style: .plain, target: self, action: #selector(codeNavigationButtonTapped))
        return barButtonItem
    }()

    var segmentControlBottomAnchor : NSLayoutYAxisAnchor?

    var selectedOption : ComparisionOption?{
        let selectedIndex = optionSegmentButton.selectedSegmentIndex
        let title = optionSegmentButton.titleForSegment(at: selectedIndex)!
        return ComparisionOption(rawValue: title)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6

        navigationItem.rightBarButtonItem = codeNavBarItem
        automationElements = [optionSegmentButton]
        addSubViews()
    }

    func addSubViews() {
        view.addSubview(optionSegmentButton)
        optionSegmentButton.translatesAutoresizingMaskIntoConstraints = false
        optionSegmentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        optionSegmentButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor).isActive = true
        optionSegmentButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor).isActive = true
        optionSegmentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        segmentControlBottomAnchor = optionSegmentButton.bottomAnchor

        optionSegmentButton.addTarget(self, action: #selector(optionSegmentButtonTapped), for: .valueChanged)
    }

    @objc func codeNavigationButtonTapped() {

    }

    @objc func optionSegmentButtonTapped(){

    }

}
