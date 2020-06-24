//
//  ManageInstructorClassScheduleViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/23/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ManageInstructorClassScheduleViewController: UIViewController {
    @IBOutlet weak var classNameText: UILabel!
    @IBOutlet weak var ManageInstructorClassScheduleTableView: UITableView!
    var exampleClassArray: [ExampleClassType] = []
    var exampleClassExample = ExampleClassType() {
        didSet {
            ManageInstructorClassScheduleTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ManageInstructorClassScheduleTableView.dataSource = self
        ManageInstructorClassScheduleTableView.delegate = self
        exampleClassArray.append(exampleClassExample)
    }
}

extension ManageInstructorClassScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleClassArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ManageClassCell", for: indexPath) as? ManageInstructorScheduleTableViewCell else { return UITableViewCell() }
        let classCell = exampleClassArray[indexPath.row]
        cell.classCell = classCell
        cell.classNameText.text = classCell.className
        cell.classTimeText.text = classCell.classTime
        return cell
    }


}
