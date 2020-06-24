//
//  ClassSearchResultsViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ClassSearchResultsViewController: UIViewController {

    @IBOutlet weak var ClassSearchResultTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        ClassSearchResultTableView.delegate = self
        ClassSearchResultTableView.dataSource = self

    }

}

extension ClassSearchResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)

        cell.detailTextLabel?.setBackground(toImageNamed: "Back")
        cell.detailTextLabel?.textColor = .white
        cell.detailTextLabel?.highlightedTextColor = .systemGray4
        cell.textLabel?.highlightedTextColor = .orange
        cell.textLabel?.text = "Class Title Here"

        return cell

    }


}
