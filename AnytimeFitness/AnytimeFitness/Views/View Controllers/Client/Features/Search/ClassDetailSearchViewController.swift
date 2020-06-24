//
//  ClassDetailSearchViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ClassDetailSearchViewController: UIViewController {
    @IBOutlet weak var classFitnessLevelTableView: UITableView!
    @IBOutlet weak var classSizeTableView: UITableView!
    @IBOutlet weak var classDurationTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var classFitnessLevelLabel: UILabel!
    @IBOutlet weak var classSizeLabel: UILabel!

    @IBOutlet weak var classDurationLabel: UILabel!

    var fitnessLevel: [String] = ["Beginner", "Intermediate", "Advanced"]
    var classSize: [String] = ["Small (1-5)", "Medium (5-15)", "Large (16+)"]
    var classDuration: [String] = ["Short (less than 30 min)", "Average (30 - 45 min)", "Long (more than 45 min)"]

    var selectedFitnessLevel: [String] = [] {
        didSet {
            if selectedFitnessLevel.isEmpty, selectedClassSize.isEmpty, selectedClassDuration.isEmpty {
                view.setLightButtonColor(toButtonNamed: nextButton)
            } else {
                view.setDarkButtonColor(toButtonNamed: nextButton)
            }
        }
    }

    var selectedClassSize: [String] = [] {
        didSet {
            if selectedClassSize.isEmpty, selectedFitnessLevel.isEmpty, selectedClassDuration.isEmpty {
                view.setLightButtonColor(toButtonNamed: nextButton)
            } else {
                view.setDarkButtonColor(toButtonNamed: nextButton)
            }
        }
    }

    var selectedClassDuration: [String] = [] {
        didSet {
            if selectedClassDuration.isEmpty, selectedClassSize.isEmpty, selectedFitnessLevel.isEmpty {
                view.setLightButtonColor(toButtonNamed: nextButton)
            } else {
                view.setDarkButtonColor(toButtonNamed: nextButton)
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        classSizeTableView.delegate = self
        classSizeTableView.dataSource = self
        classFitnessLevelTableView.delegate = self
        classFitnessLevelTableView.dataSource = self
        classDurationTableView.delegate = self
        classDurationTableView.dataSource = self
        view.setLightButtonColor(toButtonNamed: nextButton)
        classFitnessLevelLabel.layer.backgroundColor = UIColor.black.cgColor
        classFitnessLevelLabel.textColor = .white
        classSizeLabel.layer.backgroundColor = UIColor.black.cgColor
        classSizeLabel.textColor = .white
        classDurationLabel.layer.backgroundColor = UIColor.black.cgColor
        classDurationLabel.textColor = .white
    }

    @IBAction func nextButtonClicked(_ sender: UIButton) {

    }

}

extension ClassDetailSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == classFitnessLevelTableView {
            return fitnessLevel.count }
        else if tableView == classSizeTableView {
            return classSize.count
        } else {
            return classDuration.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == classFitnessLevelTableView {
            let levelCell = tableView.dequeueReusableCell(withIdentifier: "ClassFitnessLevelCell", for: indexPath)
            levelCell.textLabel?.text = fitnessLevel[indexPath.row]
            return levelCell }
        else if tableView == classSizeTableView  {
            let sizeCell = tableView.dequeueReusableCell(withIdentifier: "ClassSizeCell", for: indexPath)
            sizeCell.textLabel?.text = classSize[indexPath.row]
            return sizeCell
        } else {
            let durationCell = tableView.dequeueReusableCell(withIdentifier: "ClassDurationCell", for: indexPath)
                      durationCell.textLabel?.text = classDuration[indexPath.row]
                      return durationCell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == classFitnessLevelTableView {
            selectedFitnessLevel.append(fitnessLevel[indexPath.row])

            print("New added level array: \(selectedFitnessLevel)")

        } else if tableView == classSizeTableView {
            selectedClassSize.append(classSize[indexPath.row])
            print("New added size array: \(selectedClassSize)")
        } else if tableView == classDurationTableView {
            selectedClassDuration.append(classDuration[indexPath.row])
            print("New added duration array: \(selectedClassDuration)")
        }

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == classFitnessLevelTableView {
            selectedFitnessLevel.removeAll{ $0 == fitnessLevel[indexPath.row] }

            print("New deleted level array: \(selectedFitnessLevel)")

        } else if tableView == classSizeTableView {
            selectedClassSize.removeAll{ $0 == classSize[indexPath.row]}
            print("New deleted size array: \(selectedClassSize)")
        } else if tableView == classDurationTableView {
            selectedClassDuration.removeAll{ $0 == classDuration[indexPath.row]}
            print("New deleted duration array: \(selectedClassDuration)")
        }

    }

}

