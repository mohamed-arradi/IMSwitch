
# IMSwitch 

[![Swift Version](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)


![lMSwitch glance](https://github.com/mohamed-arradi/IMSwitch/blob/version/v1.0.0/imgs/switch-hstacks.png)

IMSwitch is a SwiftUI toggle component with image options. It provides a visually appealing and customizable way to toggle between two options.

An easy to use, customizable UISwitch which contains images. Build entirely in SwiftUI

![Demo IMSwitch](https://github.com/mohamed-arradi/IMSwitch/blob/version/v1.0.0/imgs/iphone-demo-switch.png)
## Features

- Smooth animations
- Customizable appearance
- Support for Right-to-Left (RTL) layout

## Requirements

- Swift 5.5+
- iOS 15.0+

## Installation

### Swift Package Manager (SPM)

Add the following to your `Package.swift` file:

```swift
.package(url: "https://github.com/mohamed-arradi/IMSwitch.git", from: "1.0.0")
```

## Usage

```swift
// Create an instance of ToggleState
let toggleState = ToggleState()

// Initialize IMSwitch with images and colors
let imSwitch = IMSwitch(
    leftImage: Image(systemName: "bicycle"),
    rightImage: Image(systemName: "parkingsign.circle"),
    activeColor: .white,
    circleFilledColor: .blue,
    backgroundColor: Color.white.opacity(0.85),
    animation: .easeInOut,
    animationLength: 0.35,
    toggleState: toggleState
)
```

### Properties

-   `leftImage`: The image displayed when the toggle is in the left (inactive) state.
-   `rightImage`: The image displayed when the toggle is in the right (active) state.
-   `activeColor`: The color applied to the state image.
-   `circleFilledColor`: The color of the filling circle that moves along the toggle.
-   `backgroundColor`: The background color of the toggle.
-   `animation`: The type of animation used for state transitions.
-   `animationLength`: The duration of the animation in seconds.
-   `isPrimaryOptionSelected`: Represents the state of the primary option.
-   `isRTL`: Represents the Right-to-Left (RTL) layout direction.

### Observing Changes
```swift
import SwiftUI

struct YourView: View {
    @StateObject var toggleState = ToggleState()

    var body: some View {
        IMSwitch(
            // ... other parameters ...
            toggleState: toggleState
        )
        .onReceive(toggleState.$isPrimaryOptionSelected) { newValue in
            // React to changes in isPrimaryOptionSelected
            print("isPrimaryOptionSelected changed to \(newValue)")
        }
    }
}
```


### Example with RTL

```swift
IMSwitch(
    // ... other parameters ...
    toggleState: toggleState
)
.environment(\.layoutDirection, .rightToLeft)
.frame(width: 300, height: 90)
```
IMSwitch is available under the MIT license. 
See the [LICENSE](https://github.com/mohamed-arradi/IMSwitch/blob/main/LICENSE) file for more info.
