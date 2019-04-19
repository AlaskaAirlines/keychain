// Keychain
//
// Copyright (c) 2019 Michael Babiy
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

import Foundation

public extension OSStatus {
    /// Returns error message for current OSStatus code, if any.
    ///
    /// Uses the `SecCopyErrorMessageString(_:_:)` function to obtain a human readable
    /// string. For targets running iOS 11.2 and below, the `errorMessage` will contain the **OSStatus** and a
    /// website URL where the error message can be searched for manually.
    var errorMessage: String {
        if #available(iOS 11.3, *) {
            return SecCopyErrorMessageString(self, nil)?.string ?? "Unknown OSStatus: \(self)."
        } else {
            return "OSStatus: \(self). For more information, visit https://www.osstatus.com."
        }
    }
}
