// Keychain
//
// Copyright (c) 2019 Alaska Airlines
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

class ItemsViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties

    private(set) var items: [Item]?

    // MARK: Override

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        queryKeychain()
    }

    // MARK: IBActions

    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        queryKeychain()
    }
}

// MARK: Keychain

extension ItemsViewController {
    /// Will query keychain for items of type `Item` and reload table view.
    func queryKeychain() {
        do {
            items = try keychain.items(ofType: Item.self)
        } catch { print("Error retrieving items. Error: \(error)") }

        // Reload table view.
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
