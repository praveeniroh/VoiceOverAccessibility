//
//  UIElement.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 22/03/25.
//

import UIKit

enum Framework{
    case UIKit
    case SwiftUI
}

enum UIElement{
    case button
    case switchElement
    case slider
    case stepper
    case segmentedControl
    case pageControl
    case textField
    case imageView
    case label
    case textView

    case tableView
    case customView

    var uiKitTitle: String {
        switch self{
        case .button:
            return "UIButton"
        case .switchElement:
            return "UISwitch"
        case .slider:
            return "UISlider"
        case .stepper:
            return "UIStepper"
        case .segmentedControl:
            return "UISegmentedControl"
        case .pageControl:
            return "UIPageControl"
        case .textField:
            return "UITextField"
        case .imageView:
            return "UIImageView"
        case .label:
            return "UILabel"
        case .textView:
            return "UITextView"
        case .tableView:
            return "UITableView"
        case .customView:
            return "CustomView"
        }
    }

    var swiftUITitle: String {
        switch self{
        case .button:
            return "Button"
        case .switchElement:
            return "Toggle"
        case .slider:
            return "Slider"
        case .stepper:
            return "Stepper"
            case .segmentedControl:
            return "SegmentedControl"
        case .pageControl:
            return "PageControl"
        case .textField:
            return "TextField"
        case .imageView:
            return "Image"
        case .label:
            return "Text"
        case .textView:
            return ""
        case .tableView:
            return "List"
        case .customView:
            return "CustomView"
        }
    }

    func title(for framework: Framework) -> String {
        switch framework {
        case .UIKit:
            return uiKitTitle
        case .SwiftUI:
            return swiftUITitle
        }
    }

}
