//
//  AdvancedTopics.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 23/03/25.
//

enum AdvancedTopics:CaseIterable{
    case changingDefaultOrder
    case customActions
    case customRotors
    case activationPoint
    case moreContent

    var title: String {
        switch self {
        case .changingDefaultOrder:
            return "Chaging Default Focus Order"
        case .customActions:
            return "Custom Actions"
        case .customRotors:
            return "Custom Rotors"
        case .activationPoint:
            return "Activation Point"
        case .moreContent:
            return "Adding More Content"
        }
    }

    var code : String{
        switch self {
        case .changingDefaultOrder:
            return """
                accessibilityElements = [optionSegmentButton,subViews[2],subViews[1],subViews[5],subViews[0],subViews[3],subViews[4],descriptionLabel]
                """
        case .customActions:
            return """
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

        """
        case .customRotors:
            return """
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
        """
        case .activationPoint:
            return """
    //Inside Cell
    override var accessibilityActivationPoint: CGPoint {
        get {
            return convert(toggleSwitch.center, to: nil)
        }
        set{
            super.accessibilityActivationPoint = newValue
        }
    }

    private func configureAccessibility() {
        isAccessibilityElement = true
        accessibilityLabel = titleLabel.text
        accessibilityTraits = .toggleButton

        accessibilityValue = toggleSwitch.accessibilityValue
    }
    """
        case .moreContent:
            return ""
        }
    }
}
