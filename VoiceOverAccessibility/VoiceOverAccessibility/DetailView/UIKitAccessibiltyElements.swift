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
            let uiSwitch = UISwitch()
            uiSwitch.isOn = true
            uiSwitch.onTintColor = .systemGreen
            uiSwitch.accessibilityLabel = "Aeroplane mode"
            uiSwitch.accessibilityHint = "Turns on airplane mode"

            let e1 = ElementView(title: title, element: uiSwitch as! T, description: "UISwitch mostly used in UITableViewCell. For demo purpose i've shown separately", showViewCode: true)
            return [e1]
        case .slider:
            let slider = UISlider()
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.maximumTrackTintColor = .systemGray6
            slider.minimumTrackTintColor = .systemGreen
            slider.minimumValueImage = UIImage(systemName: "speaker.fill")
            slider.maximumValueImage = UIImage(systemName: "speaker.wave.3.fill")
            slider.accessibilityLabel = "Volume slider"
            slider.accessibilityHint = "Adjusts the volume"
            slider.value = 50
            let e1 = ElementView(title: title, element: slider as! T, description: "Since the default trait type is .adjustable, the \"Adjust Value\" rotor action is available and selected by default when focusing on a UISlider.", showViewCode: true)
            return [e1]
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
            let uiSwitch = UISwitch()
            uiSwitch.isOn = true
            uiSwitch.onTintColor = .systemGreen
            return ElementView(title: title, element: uiSwitch as! T, description: "", showViewCode: false)
        case .slider:
            let slider = UISlider()
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.maximumTrackTintColor = .systemGray6
            slider.minimumTrackTintColor = .systemGreen
            slider.minimumValueImage = UIImage(systemName: "speaker.fill")
            slider.maximumValueImage = UIImage(systemName: "speaker.wave.3.fill")
            slider.value = 50

            return ElementView(title: title, element: slider as! T, description: "", showViewCode: false)
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

    var accessibilityCode : String {
        switch self{
        case .button:
            return """
            let button2 = UIButton()
            button2.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
            button2.backgroundColor = .green
            button2.clipsToBounds = true
            button2.layer.cornerRadius = 10
            button2.accessibilityLabel = "Edit"
            button2.accessibilityHint = "Edits data"
            """
        case .switchElement:
            return """
            let uiSwitch = UISwitch()
            uiSwitch.isOn = true
            uiSwitch.onTintColor = .systemGreen
            uiSwitch.accessibilityLabel = "Aeroplane mode"
            uiSwitch.accessibilityHint = "Turns on airplane mode"
            """
        case .slider:
            return """
            let slider = UISlider()
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.maximumTrackTintColor = .systemGray6
            slider.minimumTrackTintColor = .systemGreen
            slider.minimumValueImage = UIImage(systemName: "speaker.fill")
            slider.maximumValueImage = UIImage(systemName: "speaker.wave.3.fill")
            slider.value = 50
            slider.accessibilityLabel = "Volume slider"
            slider.accessibilityHint = "Adjusts the volume"
            """
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
        return ""
    }
}
