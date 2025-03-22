//
//  UIKitAccessibiltyElements.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 22/03/25.
//

import UIKit

extension UIElement{
    func accessibilityUIView<T: UIView>()-> [ElementView<T>] where T: UIView {
        let title = "Optimized Accessibility"

        switch self {
        case .button:

            let button = UIButton()
            button.setTitle("Edit", for: .normal)
            button.backgroundColor = .green
            button.clipsToBounds = true
            button.layer.cornerRadius = 10
            button.accessibilityHint = "Edits data"

            let button2 = UIButton()
            button2.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
            button2.backgroundColor = .green
            button2.clipsToBounds = true
            button2.layer.cornerRadius = 10
            button2.accessibilityLabel = "Edit"
            button2.accessibilityHint = "Edits data"
            button2.tintColor = .white


            let e1 = ElementView(title: title, element: button as! T, description: "For buttons with a title, additional Accessibility APIs are usually not required. Only Hint set.", showViewCode: true)
            let e2 = ElementView(title: title, element: button2 as! T, description: "For buttons with an image, set an accessibilityLabel to ensure VoiceOver announces the text. Additionally, provide an accessibilityHint if needed.", showViewCode: true)
            return [e1,e2]

        case .switchElement:
            break
        case .slider:
            break
        case .stepper:
            break
        case .segmentedControl:
            break
        case .pageControl:
            break
        case .textField:
            break
        case .imageView:
            break
        case .label:
            break
        case .textView:
            break
        case .tableView:
            break
        case .customView:
            break
        }
        return []
    }
}

extension UIElement{
    func defaultUIKit<T: UIView>()-> ElementView<T> where T: UIView {
        let title = "Default Accessibility"
        switch self {
        case .button:
            let button = UIButton()
            button.setTitle("Edit", for: .normal)
            button.backgroundColor = .green
            button.clipsToBounds = true
            button.layer.cornerRadius = 10
            return ElementView(title: title, element: button as! T, description: "", showViewCode: false)
        case .switchElement:
            break
        case .slider:
            break
        case .stepper:
            break
        case .segmentedControl:
            break
        case .pageControl:
            break
        case .textField:
            break
        case .imageView:
            break
        case .label:
            break
        case .textView:
            break
        case .tableView:
            break
        case .customView:
            break
        }
        return ElementView(title: "", element: UIView() as! T, description: "", showViewCode: false)
    }
}
