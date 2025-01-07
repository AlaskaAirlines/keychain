//
//  KeychainAccessAttributesTests.swift
//  KeychainTests
//
//  Created by Michael Babiy on 10/13/19.
//  Copyright © 2019 Alaska Airlines, Inc. All rights reserved.
//

import XCTest
@testable import KeychainAccess

class KeychainAccessAttributesTests: KeychainBaseCase {
    func testKeychain_AccessTypeReturnsCorrectkSecAttribute() {
        // Given, When
        let afterFirstUnlock = Keychain.AccessLevel.afterFirstUnlock
        let afterFirstUnlockThisDeviceOnly = Keychain.AccessLevel.afterFirstUnlockThisDeviceOnly
        let whenPasscodeSetThisDeviceOnly = Keychain.AccessLevel.whenPasscodeSetThisDeviceOnly
        let whenUnlocked = Keychain.AccessLevel.whenUnlocked
        let whenUnlockedThisDeviceOnly = Keychain.AccessLevel.whenUnlockedThisDeviceOnly

        // Then
        XCTAssertEqual(afterFirstUnlock.attribute, kSecAttrAccessibleAfterFirstUnlock)
        XCTAssertEqual(afterFirstUnlockThisDeviceOnly.attribute, kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
        XCTAssertEqual(whenPasscodeSetThisDeviceOnly.attribute, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
        XCTAssertEqual(whenUnlocked.attribute, kSecAttrAccessibleWhenUnlocked)
        XCTAssertEqual(whenUnlockedThisDeviceOnly.attribute, kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
    }
}
