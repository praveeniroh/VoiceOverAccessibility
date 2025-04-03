//
//  ZigZagLabelsViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 23/03/25.
//


import UIKit

final class ZigZagLabelsViewController: OptionsViewController {
    private let GREEN_ROTOR_NAME = "Green Rotor"
    private let RED_ROTOR_NAME = "Red Rotor"

    private var subViews = [UILabel]()
    private var redLabels: [UILabel] = []
    private var greenLabels: [UILabel] = []

    private var descriptionLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .systemGray2
        label.backgroundColor = .clear
        return label
    }()

    private let data:AdvancedTopics

    init(data:AdvancedTopics){
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = data.title
        addSubViews()
        configureAccessibility()
    }

    override func addSubViews() {
        super.addSubViews()

        setupZigZagLabels()

        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: subViews.last!.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }

    private func setupZigZagLabels() {
        let numberOfLabels = 6
        var previousLabel: UILabel?

        for i in 0..<numberOfLabels {
            let label = UILabel()
            label.text = "Label \(i + 1)"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            label.textColor = .white
            if i % 2 == 0 {
                label.backgroundColor = .red
                redLabels.append(label)
            }else{
                label.backgroundColor = .green
                greenLabels.append(label)
            }
            label.translatesAutoresizingMaskIntoConstraints = false

            subViews.append(label)
            view.addSubview(label)

            if let previousLabel = previousLabel {
                if i % 2 == 0 {
                    NSLayoutConstraint.activate([
                        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125), // Move left
                        label.topAnchor.constraint(equalTo: previousLabel.bottomAnchor, constant: 20)
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
                        label.topAnchor.constraint(equalTo: previousLabel.bottomAnchor, constant: 20)
                    ])
                }
            } else {
                NSLayoutConstraint.activate([
                    label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125),
                    label.topAnchor.constraint(equalTo: segmentControlBottomAnchor ?? view.safeAreaLayoutGuide.topAnchor, constant: 20)
                ])
            }

            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: 100),
                label.heightAnchor.constraint(equalToConstant: 40)
            ])

            previousLabel = label
        }
    }

    @objc override func codeNavigationButtonTapped() {
        navigationController?.pushViewController(CodeViewController(codeString: data.code), animated: true)
    }

    @objc override func optionSegmentButtonTapped(){
        configureAccessibility()
    }

    private func configureAccessibility() {
        switch selectedOption{
        case .defaultOption:
            accessibilityElements = nil
            subViews.forEach{
                $0.accessibilityCustomActions = nil
            }
            view.accessibilityCustomRotors = view.accessibilityCustomRotors?.filter{
                $0.name != self.GREEN_ROTOR_NAME && $0.name != self.RED_ROTOR_NAME
            }
            accessibilityCustomActions = nil
        case .optimized:
            switch data {
            case .changingDefaultOrder:
                accessibilityElements = (super.automationElements ?? []) + [subViews[2],subViews[1],subViews[5],subViews[0],subViews[3],subViews[4],descriptionLabel]
            case .customActions:
                addCustomActions()
            case .customRotors:
                addAccessibilityRotorAction()
            case .activationPoint:
                //Handled in separate view controller
                return
            case .moreContent:
                return
            case .tableView:
                //Handled in separate view controller
                break
            }
        case .none:
            break
        }
        setDescription()
    }


    private func addCustomActions(){
        subViews.forEach{label in
            let copyAction = UIAccessibilityCustomAction(name: "Copy", image: UIImage(systemName: "document.on.document")){_ in
                UIPasteboard.general.string = label.text
                return true
            }
            let upperCaseAction = UIAccessibilityCustomAction(name: "Format to Uppercase", image: UIImage(systemName: "document.on.document")){_ in
                label.text = label.text?.uppercased()
                return true
            }

            let lowerCaseAction = UIAccessibilityCustomAction(name: "Format to lowercase", image: UIImage(systemName: "document.on.document")){_ in
                label.text = label.text?.lowercased()
                return true
            }
            label.accessibilityCustomActions = [copyAction, upperCaseAction, lowerCaseAction]
        }
    }


    private func addAccessibilityRotorAction(){
        let redLabelRotor = UIAccessibilityCustomRotor(name: RED_ROTOR_NAME){ [self]predicate in

            guard let currentItem = predicate.currentItem.targetElement as? UILabel,let currentIndex  = redLabels.firstIndex(of: currentItem) else{
                return UIAccessibilityCustomRotorItemResult(targetElement: redLabels.first!, targetRange: nil)
            }
            let nextIndex : Int
            switch predicate.searchDirection {
            case .next:
                nextIndex = currentIndex + 1
            case .previous:
                nextIndex = currentIndex - 1
            default:
                nextIndex = -1
                break
            }

            guard nextIndex >= 0 && nextIndex < redLabels.count else {
                return nil
            }
            return UIAccessibilityCustomRotorItemResult(targetElement: redLabels[nextIndex], targetRange: nil)
        }

        let greenLabelRotor = UIAccessibilityCustomRotor(name: GREEN_ROTOR_NAME){ [self]predicate in

            guard let currentItem = predicate.currentItem.targetElement as? UILabel,let currentIndex  = greenLabels.firstIndex(of: currentItem) else{
                return UIAccessibilityCustomRotorItemResult(targetElement: greenLabels.first!, targetRange: nil)
            }
            let nextIndex : Int
            switch predicate.searchDirection {
            case .next:
                nextIndex = currentIndex + 1
            case .previous:
                nextIndex = currentIndex - 1
            default:
                nextIndex = -1
                break
            }

            guard nextIndex >= 0 && nextIndex < redLabels.count else {
                return nil
            }
            return UIAccessibilityCustomRotorItemResult(targetElement: greenLabels[nextIndex], targetRange: nil)
        }
        view.accessibilityCustomRotors = [redLabelRotor,greenLabelRotor]
    }
}

extension ZigZagLabelsViewController{
    private func setDescription(){
        switch data{
        case .changingDefaultOrder:
            descriptionLabel.text = selectedOption == .optimized ? "By default, VoiceOver navigates items from left to right and top to bottom. In this case, the default order has been overridden.Swipe left/right to navigate through the labels.While overriding the order, subviews not included in accessibilityElements become inaccessible., " : "By default, VoiceOver navigates items from left to right and top to bottom.Swipe left/right to navigate through the labels."
        case .customActions:
            descriptionLabel.text = selectedOption == .optimized ? "By default elements don't have any custom actions.VoiceOver announces `Swipe up/down to select a customview , double tap to activate`" : "Default behavios. Don't have any Custom Actions"
        case .customRotors:
            descriptionLabel.text = selectedOption == .optimized ? "A rotor action is set on the ViewController’s main view. When focusing on any element within the view, VoiceOver announces the available rotors the first time. In this example, navigating between the Green and Red labels demonstrates this behavior." : "By default No rotor action set."
        case .moreContent:
            descriptionLabel.text = selectedOption == .optimized ? "" : ""
        case .activationPoint,.tableView:
            break
        }
    }
}

#Preview{
    ZigZagLabelsViewController(data: .activationPoint)
}
