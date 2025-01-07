// KeychainAccess
//
// Copyright (c) 2025 Alaska Airlines
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import XCTest
@testable import KeychainAccess

class KeychainConfigurationTests: KeychainBaseCase {
    func testKeychain_SetupOptionReturnsCorrectConfiguration() {
        // Given, When
        let appSpecific: Keychain.SetupOption = .appSpecific(access: .afterFirstUnlock, serviceName: "AppName")
        let groupSpecific: Keychain.SetupOption = .groupSpecific(access: .afterFirstUnlock, accessGroup: "ABC.com.app.example", serviceName: "AppName")

        // Then
        XCTAssertNil(appSpecific.configuration.accessGroup)
        XCTAssertEqual(appSpecific.configuration.serviceName, "AppName")

        XCTAssertEqual(groupSpecific.configuration.accessGroup, "ABC.com.app.example")
        XCTAssertEqual(groupSpecific.configuration.serviceName, "AppName")
    }
}
