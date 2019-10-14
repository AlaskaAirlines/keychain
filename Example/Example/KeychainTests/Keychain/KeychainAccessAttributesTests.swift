//
//  KeychainAccessAttributesTests.swift
//  KeychainTests
//
//  Created by Michael Babiy on 10/13/19.
//  Copyright © 2019 Alaska Airlines, Inc. All rights reserved.
//

import XCTest
@testable import Keychain

class KeychainAccessAttributesTests: KeychainBaseCase {
    func testKeychain_AccessTypeReturnsCorrectkSecAttribute() {
        // Given, When
        let always = Keychain.Access.always
        let alwaysThisDeviceOnly = Keychain.Access.alwaysThisDeviceOnly
        let afterFirstUnlock = Keychain.Access.afterFirstUnlock
        let afterFirstUnlockThisDeviceOnly = Keychain.Access.afterFirstUnlockThisDeviceOnly
        let whenPasscodeSetThisDeviceOnly = Keychain.Access.whenPasscodeSetThisDeviceOnly
        let whenUnlocked = Keychain.Access.whenUnlocked
        let whenUnlockedThisDeviceOnly = Keychain.Access.whenUnlockedThisDeviceOnly

        // Then
        XCTAssertEqual(always.attribute, kSecAttrAccessibleAlways)
        XCTAssertEqual(alwaysThisDeviceOnly.attribute, kSecAttrAccessibleAlwaysThisDeviceOnly)
        XCTAssertEqual(afterFirstUnlock.attribute, kSecAttrAccessibleAfterFirstUnlock)
        XCTAssertEqual(afterFirstUnlockThisDeviceOnly.attribute, kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
        XCTAssertEqual(whenPasscodeSetThisDeviceOnly.attribute, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
        XCTAssertEqual(whenUnlocked.attribute, kSecAttrAccessibleWhenUnlocked)
        XCTAssertEqual(whenUnlockedThisDeviceOnly.attribute, kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
    }
}
