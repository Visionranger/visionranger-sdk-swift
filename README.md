![Swift SDK](https://resources.visionranger.com/media/repository-preview-sdk-swift.png)

# Visionranger SDK for Swift (Beta)
The Visionranger SDK for Swift makes it easy to interact with the Visionranger API. Use the library to build an iOS app that meets your custom business requirements. We provide powerful and customizable UI screens that can be used out-of-the-box to manage your product portfolio and fulfill incoming orders from customers. We also expose the low-level APIs that power those UIs so that you can build fully customizable experiences for team mates, employees or customers.

## Requirements
The Swift SDK is compatible with apps supporting iOS 11 and above.

## Installation
We support CocoaPods and Swift Package Manager. If you prefer to install the library manually, please use the latest version from our [releases](https://github.com/visionranger/visionranger-sdk-swift/releases) page.

### Swift Package Manager
To install the SDK, follow these steps:
1. In Xcode, select **File** > **Swift Packages** > **Add Package Dependency** and enter `https://github.com/visionranger/visionranger-sdk-swift` as the repository URL.
2. Select a minimum version of `0.1.0`
3. Add the **Visionranger** product to the target of your app.

### CocoaPods
1. If you haven't already, install the latest version of [CocoaPods](https://guides.cocoapods.org/using/getting-started.html).
2. If you don't have an existing [Podfile](https://guides.cocoapods.org/syntax/podfile.html), run the following command to create one:
```shell
pod init
```
3. Add this line to your Podfile:
```shell
pod 'Visionranger'
```
4. Run the following command:
```shell
pod install
```
5. Don’t forget to use the `.xcworkspace` file to open your project in Xcode, instead of the `.xcodeproj` file, from here on out.
6. In the future, to update to the latest version of the SDK, run:
```shell
pod update Visionranger
```

### Manual
1. Navigate to our [releases](https://github.com/visionranger/visionranger-sdk-swift/releases) page, download `Visionranger.xcframework.zip`, and unzip it.
2. Drag `Visionranger.xcframework` to the Frameworks, Libraries, and Embedded Content section of your Xcode project's General settings. Make sure to select "Copy items if needed".

When new versions of the SDK are released, repeat the above steps to update your installation.
