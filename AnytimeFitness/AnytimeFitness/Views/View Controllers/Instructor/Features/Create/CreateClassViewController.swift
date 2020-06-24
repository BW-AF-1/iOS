//
//  CreateClassViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/20/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class CreateClassViewController: UIViewController {

    @IBOutlet weak var classTypeSelection: UIButton!
    @IBOutlet weak var classTypeTableView: UITableView!
    @IBOutlet weak var classSizeText: UITextField!
    @IBOutlet weak var classLengthText: UITextField!
    @IBOutlet weak var classLevelSelection: UIButton!
    @IBOutlet weak var classLevelTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!

    var fitnessTypes: [String] = ["Boxing", "Dancing", "Biking", "Pilates", "Running", "Stretch", "Weightlifting", "Yoga", "Bootcamp", "Cardio", "Functional Fitness", "Ect."]

    var fitnessLevel: [String] = ["Beginner", "Intermediate", "Advanced"]

    override func viewDidLoad() {
        super.viewDidLoad()

        classTypeTableView.delegate = self
        classTypeTableView.dataSource = self
        classTypeTableView.isHidden = true

        classLevelTableView.delegate = self
        classLevelTableView.dataSource = self
        classLevelTableView.isHidden = true

        view.setLightButtonColor(toButtonNamed: nextButton)

    }

    @IBAction func classTypeSelectionClicked(_ sender: Any) {
        if classTypeTableView.isHidden {
            animateType(toggle: true)
        } else {
            animateType(toggle: false)
        }
    }

    @IBAction func classLevelSelectionClicked(_ sender: Any) {
        if classLevelTableView.isHidden {
            animateLevel(toggle: true)
        } else {
            animateLevel(toggle: false)
        }
    }


    func animateType(toggle: Bool) {
        if toggle {
            UIView.animate(withDuration: 0.3) {
                self.classTypeTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.classTypeTableView.isHidden = true
            }
        }
    }

    func animateLevel(toggle: Bool) {
        if toggle {
            UIView.animate(withDuration: 0.3) {
                self.classLevelTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.classLevelTableView.isHidden = true
            }
        }
    }
}

extension CreateClassViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == classTypeTableView {
            return fitnessTypes.count }
        else {
            return fitnessLevel.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == classTypeTableView {
            let typeCell = tableView.dequeueReusableCell(withIdentifier: "classTypeSelection", for: indexPath)
            typeCell.textLabel?.text = fitnessTypes[indexPath.row]
            return typeCell }
        else  {
            let levelCell = tableView.dequeueReusableCell(withIdentifier: "classLevelSelection", for: indexPath)
            levelCell.textLabel?.text = fitnessLevel[indexPath.row]
            return levelCell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == classTypeTableView {
            classTypeSelection.setTitle("\(fitnessTypes[indexPath.row])", for: .normal)
            animateType(toggle: false) } else if tableView == classLevelTableView {
            classLevelSelection.setTitle("\(fitnessLevel[indexPath.row])", for: .normal)
            animateLevel(toggle: false)
        }
    }

}
