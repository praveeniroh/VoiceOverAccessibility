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
            let e1 = ElementView(title: title, element: getUIStepper() as! T, description: "Both increment and decrement are treated as buttons. Accessibility label and value are set, but the hint is ignored.", showViewCode: true)
            return [e1]
        case .segmentedControl:
            let segmentedControl = UISegmentedControl(items: ["Option 1", "Option 2", "Option 3"])
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            segmentedControl.isAccessibilityElement = true
            segmentedControl.accessibilityLabel = "Options Selector"
            segmentedControl.accessibilityHint = "Swipe left or right to select an option."

            let e1 = ElementView(title: title, element:  segmentedControl as! T, description: "Custom accessibility configuration is igonre for UISegmentedControl. Provided Label, hint, and trait are ignored.", showViewCode: true)
            return [e1]

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
            return ElementView(title: title, element: getUIStepper(needAccessibilty: false) as! T, description: "", showViewCode: false)
        case .segmentedControl:
            let segmentedControl = UISegmentedControl(items: ["Option 1", "Option 2", "Option 3"])
            segmentedControl.selectedSegmentIndex = 0
            return ElementView(title: title, element: segmentedControl as! T, description: "", showViewCode: false)
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
           return """
            let stepper = UIStepper()
            stepper.maximumValue = 100
            stepper.minimumValue = 0
            stepper.value = 40
            stepper.stepValue = 20
            stepper.accessibilityLabel = "Increase or decrease the Volume"
            ///Hint not taken for this component
            stepper.accessibilityHint = "Use the Stepper to adjust the volume"
            stepper.accessibilityValue = stepper.value.description
        """
        case .segmentedControl:
            return """
            let segmentedControl = UISegmentedControl(items: ["Option 1", "Option 2", "Option 3"])
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            segmentedControl.isAccessibilityElement = true
            segmentedControl.accessibilityLabel = "Options Selector"
            segmentedControl.accessibilityHint = "Swipe left or right to select an option.
            """
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

extension UIElement{
    func getUIStepper(needAccessibilty: Bool = true) -> UIView{
        let container = UIView()


        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)

        let stepper = UIStepper()
        stepper.maximumValue = 100
        stepper.minimumValue = 0
        stepper.value = 40
        stepper.stepValue = 20
        label.text = stepper.value.description
        stepper.addAction(UIAction { action in
            label.text = stepper.value.description
            if needAccessibilty{
                stepper.accessibilityValue = stepper.value.description
            }
        }, for: .valueChanged)

        container.addSubview(stepper)
        container.addSubview(label)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        stepper.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        stepper.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        stepper.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: stepper.trailingAnchor, constant: 8).isActive = true
        label.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true

        if needAccessibilty{
            stepper.accessibilityLabel = "Increase or decrease the Volume"
            ///Hint not taken for this component
            stepper.accessibilityHint = "Use the Stepper to adjust the volume"
            stepper.accessibilityValue = stepper.value.description
        }
        return container
    }
}
