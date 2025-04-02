# VoiceOverAccessibility
This repository focuses on enhancing VoiceOver support in iOS apps using UIAccessibility APIs. It includes custom labels, traits, actions, rotors, and element grouping to improve navigation and user experience for visually impaired users in UIKit and SwiftUI.

## 🚀 How to Use This Repository
1. Clone the repository:
   ```bash
   git clone https://github.com/praveeniroh/VoiceOverAccessibility.git
   ```
2. Open/Run the project in Xcode.
3. Once Ran, Open **Settings > Accessibility > VoiceOver > Turn On VoiceOver**
> **Note:**
>If you’re new to VoiceOver and still getting used to swipe gestures, I highly recommend setting up a quick way to toggle VoiceOver on and off. You can use Back Tap or configure the Power button shortcut for easy access:  
> •	Back Tap: Go to **Settings > Accessibility > Touch > Back Tap**, then set Double Tap or Triple Tap to VoiceOver.  
> •	Power Button Shortcut: Navigate to **Settings > Accessibility > Accessibility Shortcut** and select VoiceOver to enable toggling with the Power button.  
> These shortcuts make it easier to manage VoiceOver without navigating through menus.

To explore the behavior of basic UI elements, open the UIKit tab in the Demo app and select the desired element. You’ll see both the default behavior and an optimized accessibility configuration. Additionally, a code example is provided to demonstrate the improved accessibility setup for the selected view.

![VoiceOver Accessibility Title@3x](https://github.com/user-attachments/assets/8546dccc-ef1a-4657-aab4-01b44f056ad6)


## Basic Accessibility Properties
### 🔹 **Accessibility Label**
A short description of an element for VoiceOver.
```swift
myButton.accessibilityLabel = "Play Button"
```

### 🔹 **Accessibility Value**
Used for dynamic values like progress or slider values.
```swift
mySlider.accessibilityValue = "50%"
```

### 🔹 **Accessibility Trait**
Defines the role of an element (e.g., button, header, static text).
```swift
myButton.accessibilityTraits = .button
```

### 🔹 **Accessibility Hint**
Provides additional guidance to users.
```swift
myButton.accessibilityHint = "Double-tap to play the audio"
```

### 🔹 **isAccessibilityElement**
Determines whether the view itself is an accessibility element.
```swift
myView.isAccessibilityElement = true
```

## 🔹 **Custom Rotor**
Allows users to navigate specific content faster.
```swift
let customRotor = UIAccessibilityCustomRotor(name: "Navigate Headers") { predicate in
    return UIAccessibilityCustomRotorItemResult(targetElement: someView, targetRange: nil)
}
view.accessibilityCustomRotors = [customRotor]
```

## 🔹 **Custom Action**
Adds custom interactions to accessibility elements.
```swift
let customAction = UIAccessibilityCustomAction(name: "Mark as Favorite") { action in
    markAsFavorite()
    return true
}
myButton.accessibilityCustomActions = [customAction]
```

## 🔹 **Reordering Elements Using accessibilityElements**
Manually setting the order of accessibility elements within a container.
```swift
myView.accessibilityElements = [label1, button1, textField1]
```

## SwiftUI Equivalent
### 🔹 **Accessibility Modifiers in SwiftUI**
```swift
Button("Play") {
    playAudio()
}
.accessibilityLabel("Play Button")
.accessibilityHint("Double-tap to start the audio")
.accessibilityValue("50%")
.accessibilityAddTraits(.isButton)
```

### 🔹 **Custom Rotor in SwiftUI**
```swift
struct ContentView: View {
    var body: some View {
        Text("Header 1")
            .accessibilityRotorEntry(id: "headers", in: .custom("Navigate Headers"))
    }
}
```

### 🔹 **Custom Action in SwiftUI**
```swift
Button("Favorite") {
    markAsFavorite()
}
.accessibilityAction(named: "Mark as Favorite") {
    markAsFavorite()
}
```

