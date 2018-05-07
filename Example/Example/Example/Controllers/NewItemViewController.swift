// Keychain
//
// Copyright (c) 2018 Michael Babiy
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

import UIKit

class NewItemViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // MARK: Override

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Bring up keyboard.
        websiteTextField.becomeFirstResponder()
    }

    // MARK: Actions

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard
            let website = websiteTextField.text, !website.isEmpty,
            let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
            else { print("Website, username and password text is required."); return }

        // Create an item.
        let item = Item(website: website, username: username, password: password)

        // Save to Keychain.
        do {
            try keychain.save(item)

            // Pop to `ItemsViewController` on successful save.
            navigationController?.popViewController(animated: true)
        } catch { print("Error saving to Keychain. Error: \(error)") }
    }
}
