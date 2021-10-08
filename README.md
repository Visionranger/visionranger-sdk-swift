![Swift SDK](https://resources.visionranger.com/media/repository-preview-sdk-swift.png)

# Visionranger SDK for Swift (Beta)
The Visionranger SDK for Swift makes it easy to interact with the Visionranger API. It exposes the low-level APIs that power our business workflows so that you can build fully customizable experiences for team mates, employees or customers.

Although the Visionranger SDK is an open source project, it is not intended for general use. We don't recommend that third parties depend upon it. Doing so is likely to be frustrating because there are no guarantees of API or ABI stability.

## Requirements
The Swift SDK is compatible with apps supporting iOS 11 and above.
In order to use this SDK, you have to have an account-specific API access key, that needs to be requested from your account manager.

## Installation
We support CocoaPods and Swift Package Manager. If you prefer to install the library manually, please use the latest version from our [releases](https://github.com/visionranger/visionranger-sdk-swift/releases) page.

### Swift Package Manager
To install the SDK, follow these steps:
1. In Xcode, select **File** > **Swift Packages** > **Add Package Dependency** and enter `https://github.com/visionranger/visionranger-sdk-swift` as the repository URL.
2. Select a minimum version of `0.1.0`
3. Add the **Visionranger** product to the target of your app.

---

### CocoaPods
1. If you haven't already, install the latest version of [CocoaPods](https://guides.cocoapods.org/using/getting-started.html).
2. If you don't have an existing [Podfile](https://guides.cocoapods.org/syntax/podfile.html), run the following command to create one:
```shell
$ pod init
```
3. Add this line to your Podfile:
```shell
$ pod 'Visionranger'
```
4. Run the following command:
```shell
$ pod install
```
5. Don’t forget to use the `.xcworkspace` file to open your project in Xcode, instead of the `.xcodeproj` file, from here on out.
6. In the future, to update to the latest version of the SDK, run:
```shell
$ pod update Visionranger
```

---

### Manual
1. Navigate to our [releases](https://github.com/visionranger/visionranger-sdk-swift/releases) page, download `Visionranger.xcframework.zip`, and unzip it.
2. Drag `Visionranger.xcframework` to the Frameworks, Libraries, and Embedded Content section of your Xcode project's General settings. Make sure to select "Copy items if needed".

When new versions of the SDK are released, repeat the above steps to update your installation.


## Get started
Before using this SDK, you should register your application by contacting your account manager. Doing this, the account manager will create a record of your app on your behalf that will be associated with the API calls you make.
All requests need to be made with an API Key specific to your app. The API Key represents an authenticated link between a Visionranger app and your Visionranger partner account.

## Contributing

### Naming conventions
To provide a consistant developer experience, all names for classes, functions, file names, variables & constants have to meet the following guidelines:

#### Class Names
All classes that have at least `public` scope, need to start with the library identifier `VSN`, followed by the class name itself, written in `UpperCamelCase`, where the first letter is capitalized.

Classes that have `internal` or lower scope, can ommit the library identifier, but have to still be written in `UpperCamelCase`.

Example public class:
```swift
public class VSNAPIClient: NSObject {

    public static let shared: VSNAPIClient = {
        let client = VSNAPIClient()
        return client
    }()

    var apiURL: URL! = URL(string: APIBaseURL)

    func configuredRequest(for url: URL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        return request
    }
    ...
}
```
Example internal class:
```swift
class APIRequest<ResponseType: VSNAPIResponseDecodable: NSObject {
    typealias VSNAPIResponseBlock = (ResponseType?, HTTPURLResponse?, Error?) -> Void

    class func someFunctionName() {
        ...
    }
    ...
}
```

---

#### File Names
The file name is defined according to it's content. If the primary content of the file is a custom class, the filename must match the name of the class. If the primary content is an extension of a third-party library, the filename is `third-party class name + Visionranger` (written without any whitespaces).

Default file name example:
```shell
ClassName.swift
```
```shell
VSNAPIClient.swift
```

Extension file name example:
```shell
ThirdPartyClassName+Visionranger.filetype
```
```shell
URLEncoder+Visionranger.swift
```

There is one exception to the file naming conventions specified above. In case the file is meant as an extension and contains only one function or specific purpose, the file will be named according to that specific purpose instead of `+Visionranger`.

Single purpose Extension example:
```shell
ThirdPartClassName+Purpose.filetype
```
```shell
URLSession+Retry.swift
```

---

#### Function Names
Like the file naming conventions, there are two different types of functions. The type of function is part of a custom class or global file scope. Those functions are written in `lowerCamelCase`.
The second type of function is part of an extension for a third party library, as specified above. Those functions are written in `lowerCamelCase` as well + that they start with `vsn_`.

Default function example:
```swift
someFunctionName(parameter: DataType) { }
```
Function inside a third party library extension example:
```swift
vsn_someFunctionName(parameter: DataType) { }
```

---

#### Variable & Constant Names
Variables and constants are always written in `lowerCamelCase`. The only exception are global constants at file level - those are written in `UpperCamelCase`.

Default example:
```swift
var myGenericVariable: Int = 5
let myGenericConstant: String = "This is a fixed string"
```

Global file scope example:
```swift
private let APIVersion = "2021-09-23
```

### Commit Conventions
This project follows the **Conventional Commit specification** throughout. It is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of.

The commit message should be structured as follows:
```shell
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

The commit contains the following structural elements, to communicate intent to the consumers of your library:
1. **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with [`PATCH`](http://semver.org/#summary) in Semantic Versioning).
2. **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with [`MINOR`](http://semver.org/#summary) in Semantic Versioning).
3. **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE`:, or appends a `!` after the type/scope, introduces a breaking API change (correlating with [`MAJOR`](http://semver.org/#summary) in Semantic Versioning). A `BREAKING CHANGE` can be part of commits of any type.
4. types other than `fix`: and `feat`: are allowed, for example [@commitlint/config-conventional](https://github.com/conventional-changelog/commitlint/tree/master/%40commitlint/config-conventional) (based on the the [Angular convention](https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#-commit-message-guidelines)) recommends `build:`, `chore:`, `ci:`, `docs:`, `style:`, `refactor:`, `perf:`, `test:`, and others.
5. footers other than `BREAKING CHANGE: <description>` may be provided and follow a convention similar to [git trailer format](https://git-scm.com/docs/git-interpret-trailers).

---

Additional types are not mandated by the Conventional Commits specification, and have no implicit effect in Semantic Versioning (unless they include a BREAKING CHANGE). A scope may be provided to a commit’s type, to provide additional contextual information and is contained within parenthesis, e.g., `feat(parser): add ability to parse arrays`.

---

For further details and a complete guide to all specifications as well as examples, visit [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).
