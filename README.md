## Overview

> Supports iOS only.  

Keychain is a wrapper library built around a small subset of features offered by Keychain Services to simplify saving and retrieving data to and from the iOS Keychain using `kSecClassGenericPassword` class.

While the Keychain Services offer comprehensive set of APIs and could be used directly, the app-side implementation for saving and retrieving data will most likely be verbose.

In a nutshell, to securely store an item using Keychain Services, a dictionary of predefined keys and values, also referred to as the _keychain query_, must be created first. This query must contain valid values for predefined set of keys that depend on a security class being used. To reduce the amount of manual work required to create a keychain query, this framework takes advantage of Swift features such as default implementation for protocols, generics and `Codable` for automatic encoding of models into external representation.

This approach leads to a much cleaner interaction with iOS Keychain that's enjoyable to use.


## Features
- [x] Simple to setup, easy to use & efficient
- [x] Supports custom data types
- [x] Supports storing multiple instances of the same type
- [x] Supports app and group-specific keychain configurations
- [x] Supports selective Type synchronization through iCloud
- [x] Handles object encoding and decoding from data returned by the iOS keychain
- [x] Comprehensive Unit Test Coverage
- [x] Complete Documentation


## Requirements
* iOS 10.0+
* Xcode 9.0+
* Swift 4.0+


## Installation
Carthage is the only supported way to install Keychain framework.

```
git "https://github.com/AlaskaAirlines/keychain" "v1.0.0"
```

For more information on getting started with Carthage, visit the [repo](https://github.com/Carthage/Carthage).


## Usage
Keychain framework currently supports two access types - App Specific and Group Specific.

Getting started is easy. First, create the keychain instance using one of the supported access types.

```
let keychain = Keychain(access: .appSpecific(serviceName: "App"))
```

Any custom type you want to encrypt and store in iOS Keychain needs to conform and implement the `KeychainItem` protocol. The `KeychainItem` protocol provides default implementation for all of its properties - except the `idKey`. See documentation for more information.

```
struct Credential: KeychainItem {
    let username: String
    let password: String

    // MARK: KeychainItem

    var idKey: String {
        return username
    }
}
```

Keychain offers a handful of methods that will allow you to save, delete, or retrieve items.

```
let user = User(username: "username", password: "password")

// save
try? keychain.save(user)

// retrieve users
let users = try? keychain.items(ofType: User.self)

// retrieve a single user
let user = try? keychain.item(ofType: User.self, idKey: "username")
```

For group specific configuration, please see documentation.


## Performance
The following tests were performed on an iPad Mini 4 WiFi + Cellular. The numbers are the average for performing each operation 3000 times.

* Deleting: 0.00662
* Inserting: 0.00862
* Reading: 0.00291
* Replacing: 0.00858


## Communication
* If you found a bug, open an issue.
* If you have a feature request, open an issue.
* If you want to contribute, submit a pull request.


## Authors
* [Michael Babiy](https://github.com/michaelbabiy)

## Contributors
* [Adam Wallraff](https://github.com/awallraff)
* Krishna Varma
