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

    let classManagementContoller = ClassManagementController()

    var searchedClasses: [NewClass] = [] {
        didSet {
            print("searched class result: \(searchedClasses)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ClassSearchResultTableView.delegate = self
        ClassSearchResultTableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let nextVC = segue.destination as? ClassReserveSearchViewController, let indexPath = ClassSearchResultTableView.indexPathForSelectedRow else { return }
        let selectedClass = searchedClasses[indexPath.row]
        nextVC.finalClass = selectedClass
        }
}

extension ClassSearchResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedClasses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        cell.detailTextLabel?.text = classManagementContoller.formatClassTime(with: searchedClasses[indexPath.row])
        cell.textLabel?.text = searchedClasses[indexPath.row].classNameCD
        return cell
    }

}
