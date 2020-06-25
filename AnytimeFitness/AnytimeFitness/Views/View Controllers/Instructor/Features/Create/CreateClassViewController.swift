//
//  CreateClassViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/20/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class CreateClassViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var classTypeSelection: UIButton!
    @IBOutlet weak var classTypeTableView: UITableView!
    @IBOutlet weak var classSizeText: UITextField!
    @IBOutlet weak var classLengthText: UITextField!
    @IBOutlet weak var classLevelSelection: UIButton!
    @IBOutlet weak var classLevelTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!

    var classType: CreateClassType? {
        didSet {
            nextButton.setDarkButtonColor(toButtonNamed: nextButton)
        }
    }
    var selectionType: String?
    var selectionLevel: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        classSizeText.delegate = self
        classLengthText.delegate = self

        classTypeTableView.delegate = self
        classTypeTableView.dataSource = self
        classTypeTableView.isHidden = true

        classLevelTableView.delegate = self
        classLevelTableView.dataSource = self
        classLevelTableView.isHidden = true

        view.setLightButtonColor(toButtonNamed: nextButton)
    }

    override func viewWillAppear(_ animated: Bool) {
         if classType != nil {
                   classSizeText.text = nil
                   classLengthText.text = nil
            classLevelSelection.setTitle("Select Class Type", for: .normal)
            classTypeSelection.setTitle("Select Class Level", for: .normal)
            selectionType = nil
            selectionLevel = nil
            classType = nil
            view.setLightButtonColor(toButtonNamed: nextButton)
               }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)

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

    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let newType = selectionType, let newLevel = selectionLevel, let classSizeInt = classSizeText.text, !classSizeInt.isEmpty, let classLengthInt = classLengthText.text, !classLengthInt.isEmpty else { return }
        classType = CreateClassType(classDuration: Int(classLengthInt)!, classType: newType, classLevel: newLevel, classMaxSize: Int(classSizeInt)!)
        print("new classType Saved: \(String(describing: classType))")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextVC = segue.destination as? CreateClassNameViewController, let newClassType = classType else { return }
        nextVC.classType = newClassType
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        if identifier == "showClassName" {
            if classType == nil {
                let alert = UIAlertController(
                    title: "Alert",
                    message: "Missing input values.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return false
            }
        }

        return true
    }
}

extension CreateClassViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == classTypeTableView {
            return ClassTypeInt.allFitnessTypeKeys.count } else {
            return ClassLevelInt.allClassLevelKeys.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == classTypeTableView {
            let typeCell = tableView.dequeueReusableCell(withIdentifier: "classTypeSelection", for: indexPath)
            typeCell.textLabel?.text = ClassTypeInt.allFitnessTypeNames[indexPath.row]
            return typeCell }
        else  {
            let levelCell = tableView.dequeueReusableCell(withIdentifier: "classLevelSelection", for: indexPath)
            levelCell.textLabel?.text = ClassLevelInt.allClassLevelNames[indexPath.row]
            return levelCell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == classTypeTableView {
            classTypeSelection.setTitle("\(ClassTypeInt.allFitnessTypeNames[indexPath.row])", for: .normal)
            animateType(toggle: false)
            selectionType = ClassTypeInt.allFitnessTypeNames[indexPath.row]
        } else if tableView == classLevelTableView {
            classLevelSelection.setTitle("\(ClassLevelInt.allClassLevelNames[indexPath.row])", for: .normal)
            animateLevel(toggle: false)
            selectionLevel = ClassLevelInt.allClassLevelNames[indexPath.row]
        }
    }

}
