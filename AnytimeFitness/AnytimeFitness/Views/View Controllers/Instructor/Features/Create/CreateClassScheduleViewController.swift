//
//  CreateClassScheduleViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/21/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class CreateClassScheduleViewController: UIViewController {
    @IBOutlet weak var classCostText: UITextField!

    @IBOutlet weak var classTimeDatePicker: UIDatePicker!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var classDaysTableView: UITableView!

    var classDays: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var selectedClassDays: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        classDaysTableView.delegate = self
        classDaysTableView.dataSource = self
        classDaysTableView.layer.borderWidth = 1
        classDaysTableView.layer.borderColor = UIColor.black.cgColor
        nextButton.setDarkButtonColor(toButtonNamed: nextButton)
    }
}

extension CreateClassScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classDays.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassDaysCell", for: indexPath)
        cell.textLabel?.text = classDays[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedClassDays.append(classDays[indexPath.row])
        print("New added class days array: \(selectedClassDays)")
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedClassDays.removeAll{ $0 == classDays[indexPath.row] }

        print("New deleted class days array: \(selectedClassDays)")
    }
}
