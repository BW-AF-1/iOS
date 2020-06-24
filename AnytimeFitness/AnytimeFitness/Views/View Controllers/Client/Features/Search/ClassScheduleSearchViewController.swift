//
//  ClassScheduleSearchViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ClassScheduleSearchViewController: UIViewController {

    @IBOutlet weak var classNameTitle: UILabel!
    @IBOutlet weak var classScheduleTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        classScheduleTableView.delegate = self
        classScheduleTableView.dataSource = self
    }
}

extension ClassScheduleSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath)
        cell.textLabel?.text = "Class Name Here"
        cell.detailTextLabel?.text = "7:00 am"
        return cell
    }


}
