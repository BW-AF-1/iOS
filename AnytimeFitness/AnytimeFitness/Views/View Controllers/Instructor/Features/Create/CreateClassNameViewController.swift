//
//  CreateClassNameViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/21/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class CreateClassNameViewController: UIViewController {
    @IBOutlet weak var classNameText: UITextField!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var classDatePicker: UIDatePicker!
    @IBOutlet weak var classLocationText: UITextField!
    var className: CreateClassName? {
        didSet {
            finishButton.setDarkButtonColor(toButtonNamed: finishButton)
        }
    }
    var classType: CreateClassType?
    var classCreated: NewClass?
    var currentInstructor = NetworkController.sharedNetworkController.currentCDInstructor

    override func viewDidLoad() {
        super.viewDidLoad()
        finishButton.setLightButtonColor(toButtonNamed: finishButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        if className != nil {
            classNameText.text = nil
            classLocationText.text = nil
            className = nil
            view.setLightButtonColor(toButtonNamed: finishButton)
        }
    }

    @IBAction func finishButtonClicked(_ sender: Any) {
        guard let name = classNameText.text, !name.isEmpty, let address = classLocationText.text, !address.isEmpty, let existingClassType = classType, let currentInstructor = currentInstructor else { return }
        className = CreateClassName(className: name, classDate: classDatePicker.date, classLocation: address)
        classCreated = NewClass(classDateCD: classDatePicker.date, classDurationCD: Int16(existingClassType.classDuration), classLevelCD: existingClassType.classLevel, classLocationCD: address, classMaxSizeCD: Int16(existingClassType.classMaxSize), classNameCD: name, classTypeCD: existingClassType.classType, instructorID: currentInstructor.instructorID, context: CoreDataStack.shared.mainContext)
        guard let classCreated = classCreated else { return }
        NetworkController.sharedNetworkController.createClass(newClass: classCreated)
        currentInstructor.addToCreatedClasses(classCreated)
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
        print("Newly created class: \(String(describing: classCreated))")
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        if identifier == "showCreatedClass" {
            if className == nil {
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
