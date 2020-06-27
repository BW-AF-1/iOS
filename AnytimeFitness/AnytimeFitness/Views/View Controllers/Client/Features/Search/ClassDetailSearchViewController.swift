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

    var selectedLocations: [NewClass] = []
    var selectedDetail: [NewClass] = [] {
        didSet {
            print("final selection: \(selectedDetail)")
        }
    }

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
        var classLevel: [NewClass] = []
        var classSize: [NewClass] = []
        var classDuration: [NewClass] = []

        for element in selectedLocations {
            for item in selectedFitnessLevel {
                if element.classLevelCD.contains(find: item) {
                    classLevel.append(element)
                }
            }
            for size in selectedClassSize {
                if size.containsIgnoringCase(find: "small") {
                    if element.classMaxSizeCD < 6 {
                        classSize.append(element)
                    }
                } else if size.containsIgnoringCase(find: "medium") {
                    if element.classMaxSizeCD > 5 && element.classMaxSizeCD < 16 {
                        classSize.append(element)
                    } else if size.containsIgnoringCase(find: "large") {
                        if element.classMaxSizeCD > 15 {
                            classSize.append(element)
                        }
                    }
                }
            }
            for time in selectedClassDuration {
                if time.containsIgnoringCase(find: "short") {
                    if element.classDurationCD < 31 {
                        classDuration.append(element)
                    }
                } else if time.containsIgnoringCase(find: "average") {
                    if element.classDurationCD > 30 && element.classDurationCD < 46 {
                        classDuration.append(element)
                    } else if time.containsIgnoringCase(find: "long") {
                        if element.classDurationCD > 45 {
                            classDuration.append(element)
                        }
                    }
                }

            }
        }
        for everything in selectedLocations {
            if classLevel.contains(everything) && classSize.contains(everything) && classDuration.contains(everything){
                selectedDetail.append(everything)
            }
        }
        viewDidLoad()
        print("selected details: \(selectedDetail)")
        print("class level detail: \(classLevel)")
        print ("class duration details: \(classDuration)")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let nextVC = segue.destination as? ClassSearchResultsViewController else { return }
            nextVC.searchedClasses = selectedDetail
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

