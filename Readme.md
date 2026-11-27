# SwiftUI App Icon Switcher

A simple SwiftUI implementation that allows users to change their app's Home Screen icon at runtime.

## Features

- Switch between default and alternate app icons.
- Display icon previews in SwiftUI.
- Show the currently selected icon.
- Restore the primary icon.
- Support multiple alternate icons.

## Requirements

- Xcode
- Swift
- iOS 10.3 or later
- Asset catalog

## Asset Catalog Structure

```text
Assets.xcassets
├── AppIcon
├── AppIcon-Dark
├── DefaultIconPreview
└── DarkIconPreview
```

**Important:** App Icon sets and regular Image Sets are different. App Icon sets are used by iOS, while Image Sets are used to display previews in SwiftUI.

## Xcode Configuration

Configure the app target's Build Settings:

| Setting | Value |
|---|---|
| Primary App Icon Set Name | AppIcon |
| Alternate App Icon Sets | AppIcon-Dark |

Ensure Xcode includes the alternate icon set in the compiled application and generates the appropriate `CFBundleAlternateIcons` metadata.

## SwiftUI Implementation

The complete implementation is provided in `SettingsView.swift` in this example.

The main API is:

```swift
UIApplication.shared.setAlternateIconName("AppIcon-Dark") { error in
    if let error {
        print("Failed: \(error.localizedDescription)")
    } else {
        print("Icon changed successfully")
    }
}
```

Restore the default icon:

```swift
UIApplication.shared.setAlternateIconName(nil)
```

## Adding More Icons

To add another icon:

1. Create an App Icon set, such as `AppIcon-Blue`.
2. Add its 1024 × 1024 icon image.
3. Create a corresponding Image Set, such as `BlueIconPreview`.
4. Register the alternate icon in the asset catalog build configuration.
5. Add a new case to the `AppIcon` enum.

The existing `ForEach(AppIcon.allCases)` automatically displays the new option.

## Troubleshooting

- **Generic icon placeholder:** Verify the actual image is assigned to the App Icon set, not just its preview Image Set.
- **Missing image warnings:** Use separate Image Sets for SwiftUI previews.
- **Alternate icon not found:** Verify the asset name and generated Info.plist metadata.
- **Multiple Info.plist build commands:** Avoid processing the same plist through multiple build steps.

## How It Works

- `UIApplication.shared` accesses the running application.
- `supportsAlternateIcons` checks alternate icon support.
- `setAlternateIconName()` requests an icon change.
- Passing `nil` restores the primary icon.
- `alternateIconName` identifies the currently selected alternate icon.
- The completion handler reports the result of the asynchronous operation.

## Apple Documentation

- [UIApplication](https://developer.apple.com/documentation/uikit/uiapplication)
- [setAlternateIconName](https://developer.apple.com/documentation/uikit/uiapplication/setalternateiconname(_:completionhandler:))

## License

Choose a license before publishing this repository.
