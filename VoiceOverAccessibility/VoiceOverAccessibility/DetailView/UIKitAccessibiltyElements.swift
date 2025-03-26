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

            ///By default, VoiceOver announces a `UIButton`’s title along with the Button trait. In most cases,
            ///if the title is descriptive, no additional accessibility data is needed.
            /// However, if the button lacks a title or has a non-descriptive one, you should set an `accessibilityLabel` and `accessibilityHint`.
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

///`------------------------------------------------------------------------------------------------------------------`

        case .switchElement:

            ///By default, VoiceOver announces a `UISwitch` with its state (On/Off) and the `toggleButton` trait.
            ///If needed, you can provide an `accessibilityLabel` for context and an `accessibilityHint` for additional guidance, and a custom `accessibilityValue` to provide a more descriptive state representation instead of On/Off..
            ///Announcement order : `accessibilityLabel` >> `Switch` Button(trait) >> `On/Off `>> `accessibilityHint` >> `Double tap to toggle settings `(system announcement)

            let uiSwitch = UISwitch()
            uiSwitch.isOn = true
            uiSwitch.onTintColor = .systemGreen
            uiSwitch.accessibilityLabel = "Aeroplane mode"
            uiSwitch.accessibilityHint = "Turns on airplane mode"

            let e1 = ElementView(title: title, element: uiSwitch as! T, description: "UISwitch mostly used in UITableViewCell. For demo purpose i've shown separately", showViewCode: true)
            return [e1]

///`==================================================================================================================`

        case .slider:

            ///By default, VoiceOver announces a `UISlider` with its value, and the `Adjustable` trait. Users can adjust the value using up/down  swipe gestures. To enhance accessibility, you can set an `accessibilityLabel` for context, an `accessibilityHint` for guidance, and a custom `accessibilityValue` to provide a more descriptive representation of the slider’s state.
            ///Annoucement order : `accessibilityLabel` >>  `value` >> `adjustable`(trait) >> `accessibilityHint`
            let slider = UISlider()
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.maximumTrackTintColor = .systemGray6
            slider.minimumTrackTintColor = .systemGreen
            slider.minimumValueImage = UIImage(systemName: "speaker.fill")
            slider.maximumValueImage = UIImage(systemName: "speaker.wave.3.fill")

            //Accessibility configuration
            slider.accessibilityLabel = "Volume slider"
            slider.accessibilityHint = "Adjusts the volume"
            slider.value = 50 //Setting the value before configuring accessibility prevents VoiceOver from announcing it properly

            let e1 = ElementView(title: title, element: slider as! T, description: "Since the default trait type is .adjustable, the \"Adjust Value\" rotor action is available and selected by default when focusing on a UISlider.", showViewCode: true)
            return [e1]

///`==================================================================================================================`

        case .stepper:

            let e1 = ElementView(title: title, element: getUIStepper() as! T, description: "Both increment and decrement are treated as buttons. Accessibility label and value are set, but the hint is ignored.", showViewCode: true)
            return [e1]

///`==================================================================================================================`

        case .segmentedControl:

            ///By default, VoiceOver announces a `UISegmentedControl` with its selected segment.
            ///However, if a custom `accessibilityLabel`, `accessibilityHint`, or `trait` is provided, they are ignored.
            ///Announcement order : `Selected`(if selected option focused)>> `Option 1`(index of item) >> `Button`(trait) >> `1 of 3` (index + total options)
            let segmentedControl = UISegmentedControl(items: ["Option 1", "Option 2", "Option 3"])
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            segmentedControl.isAccessibilityElement = true
            segmentedControl.accessibilityLabel = "Options Selector"
            segmentedControl.accessibilityHint = "Swipe left or right to select an option."

            let e1 = ElementView(title: title, element:  segmentedControl as! T, description: "Custom accessibility configuration is igonre for UISegmentedControl. Provided Label, hint, and trait are ignored.", showViewCode: true)
            return [e1]

///`==================================================================================================================`

        case .pageControl:
            let pageControl = UIPageControl()
            pageControl.numberOfPages = 5
            pageControl.currentPage = 0
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.pageIndicatorTintColor = .secondaryLabel
            pageControl.currentPageIndicatorTintColor = .systemBlue

            pageControl.accessibilityLabel = "Offers Pages"
            pageControl.accessibilityHint = "Changes different offers card "
            let e1 = ElementView(title: title, element:  pageControl as! T, description: "By default value announced Properly.In this example, custom labe and hint set", showViewCode: true)
            return [e1]
        case .textField:
            let textField = UITextField()
            textField.placeholder = "Enter search text"
            textField.borderStyle = .roundedRect

            // Accessibility Configuration
            textField.isAccessibilityElement = true
            textField.accessibilityLabel = "Text Input Field"
            textField.accessibilityHint = "Search contact records"
            textField.accessibilityTraits = .searchField

            let e1 = ElementView(title: title, element:  textField as! T, description: "In this example, custom label,trait and hint set", showViewCode: true)
            return [e1]
        case .imageView:
            let imageView = UIImageView(image: UIImage(resource: .profile))
            imageView.translatesAutoresizingMaskIntoConstraints = true
            imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

            // Accessibility Configuration
            imageView.isAccessibilityElement = true
            imageView.accessibilityLabel = "Profile image"
            imageView.accessibilityHint = "Double tap to edit profile"
            imageView.accessibilityTraits = [.image,.button]

            let imageView2 = UIImageView(image: UIImage(resource: .decorative))
            imageView2.translatesAutoresizingMaskIntoConstraints = true
            imageView2.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imageView2.widthAnchor.constraint(equalToConstant: 100).isActive = true


            let e1 = ElementView(title: title, element:  imageView as! T, description: "In this example, custom label,trait and hint set", showViewCode: true)

            let e2 = ElementView(title: title, element:  imageView2 as! T, description: "For purely decorative images, we can avoid making them accessibility elements or explicitly disable accessibility. By default, a UIImageView is not accessible.", showViewCode: false)

            return [e1,e2]
        case .label:
            let label = UILabel()
            label.text = "Hello, World!"
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .black

            // Accessibility Configuration
            label.accessibilityHint = "Displays a greeting message."
            label.accessibilityTraits = .staticText

            let e1 = ElementView(title: title, element:  label as! T, description: "By default, VoiceOver announces the text for UILabel , have added Hint and trait", showViewCode: true)
            return [e1]
        case .textView:
            let textView = UITextView()
            textView.text = "This is a sample text."
            textView.font = UIFont.systemFont(ofSize: 16)
            textView.textColor = .black
            textView.isScrollEnabled = true
            textView.layer.borderWidth = 1
            textView.layer.borderColor = UIColor.gray.cgColor
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.heightAnchor.constraint(equalToConstant: 100).isActive = true

//            textView.isEditable = false

            // Accessibility Configuration
            textView.accessibilityLabel = "Description text view"
            textView.accessibilityHint = "Add description about a record here."

            let e1 = ElementView(title: title, element:  textView as! T, description: "VoiceOver announces UITextView correctly by default. Label and hint are added. If editing is disabled, “Double tap to edit” is not announced.", showViewCode: true)
            return [e1]
        case .tableView:
            break
        case .customView:
            let customView = CustomButtonView()

            //Accessibility Configs
            customView.isAccessibilityElement = true
            customView.accessibilityLabel = "Profile view"
            customView.accessibilityTraits = [.button]
            customView.accessibilityHint = "Updates profile image"

            let e1 = ElementView(title: title, element:  customView as! T, description: "Wraped all subviews as a single accessibility element.Provided custom label,hint and trait", showViewCode: true)
            return [e1]
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
            let pageControl = UIPageControl()
            pageControl.numberOfPages = 5
            pageControl.currentPage = 0
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.pageIndicatorTintColor = .secondaryLabel
            pageControl.currentPageIndicatorTintColor = .systemBlue

            let e1 = ElementView(title: title, element:  pageControl as! T, description: "", showViewCode: false)
            return e1
        case .textField:
            let textField = UITextField()
            textField.placeholder = "Enter search text"
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false

            let e1 = ElementView(title: title, element:  textField as! T, description: "", showViewCode: false)
            return e1
        case .imageView:
            let imageView = UIImageView(image: UIImage(resource: .profile))
            imageView.translatesAutoresizingMaskIntoConstraints = true
            imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

            let e1 = ElementView(title: title, element:  imageView as! T, description: "By default, a UIImageView is not accessible.", showViewCode: false)
            return e1
        case .label:
            let label = UILabel()
            label.text = "Hello, World!"
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .black
            let e1 = ElementView(title: title, element:  label as! T, description: "", showViewCode: false)
            return e1
        case .textView:
            let textView = UITextView()
            textView.text = "This is a sample text."
            textView.font = UIFont.systemFont(ofSize: 16)
            textView.textColor = .black
            textView.isScrollEnabled = true
            textView.layer.borderWidth = 1
            textView.layer.borderColor = UIColor.gray.cgColor

            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.heightAnchor.constraint(equalToConstant: 100).isActive = true

            let e1 = ElementView(title: title, element:  textView as! T, description: "", showViewCode: false)
            return e1
        case .tableView:
            break
        case .customView:
            let customView = CustomButtonView()
            let e1 = ElementView(title: title, element:  customView as! T, description: "", showViewCode: false)
            return e1
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
            return """
            let pageControl = UIPageControl()
            pageControl.numberOfPages = 5
            pageControl.currentPage = 0
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.pageIndicatorTintColor = .secondaryLabel
            pageControl.currentPageIndicatorTintColor = .systemBlue

            pageControl.accessibilityLabel = "Offers Pages"
            pageControl.accessibilityHint = "Changes different offers card "
            """
        case .textField:
            return """
            let textField = UITextField()
            textField.placeholder = "Enter search text"
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false

            // Accessibility Configuration
            textField.isAccessibilityElement = true
            textField.accessibilityLabel = "Text Input Field"
            textField.accessibilityHint = "Search contact records"
            textField.accessibilityTraits = .searchField
            """
        case .imageView:
            return """
            let imageView = UIImageView(image: UIImage(resource: .profile))
            imageView.translatesAutoresizingMaskIntoConstraints = true
            imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

            // Accessibility Configuration
            imageView.isAccessibilityElement = true
            imageView.accessibilityLabel = "Profile image"
            imageView.accessibilityHint = "Double tap to edit profile"
            imageView.accessibilityTraits = [.image,.button]
            """
        case .label:
            return """
            let label = UILabel()
            label.text = "Hello, World!"
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .black

            // Accessibility Configuration
            label.accessibilityHint = "Displays a greeting message."
            label.accessibilityTraits = .staticText
            """
        case .textView:
            return """
            let textView = UITextView()
            textView.text = "This is a sample text."
            textView.font = UIFont.systemFont(ofSize: 16)
            textView.textColor = .black
            textView.isScrollEnabled = true
            textView.layer.borderWidth = 1
            textView.layer.borderColor = UIColor.gray.cgColor
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.heightAnchor.constraint(equalToConstant: 100).isActive = true

            //textView.isEditable = false

            // Accessibility Configuration
            textView.accessibilityLabel = "Description text view"
            textView.accessibilityHint = "Add description about a record here."
            """
        case .tableView:
            break
        case .customView:
            return """
            let customView = CustomButtonView()

            //Accessibility Configs
            customView.isAccessibilityElement = true
            customView.accessibilityLabel = "Profile view"
            customView.accessibilityTraits = [.button]
            customView.accessibilityHint = "Updates profile image"
            """
        }
        return ""
    }
}

extension UIElement{
    func getUIStepper(needAccessibilty: Bool = true) -> UIView{
        let container = UIView()


        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)

        ///By default, VoiceOver announces a `UIStepper` with its current value . It provides Increment and Decrement actions as buttons. If needed, you can set an `accessibilityLabel` for context . You can also provide a custom `accessibilityValue` for better clarity.
        /// `accessibilityHint` value ignored.
        ///Order : accessibilityLabel >> Increment/Decrement  >> value or accessibilityValue >> Button(trait0
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
