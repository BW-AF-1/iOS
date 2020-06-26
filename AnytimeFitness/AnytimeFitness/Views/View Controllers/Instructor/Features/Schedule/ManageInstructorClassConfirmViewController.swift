//
//  ManageInstructorClassConfirmViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/23/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ManageInstructorClassConfirmViewController: UIViewController {

    @IBOutlet weak var classNameText: UITextField!
    @IBOutlet weak var classDatePicker: UIDatePicker!

    @IBOutlet weak var classLocationText: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    var updateClass: InstructorCreateClassController.ExampleClassType?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let toUpdate = updateClass else { return }
        classNameText.text = toUpdate.className
        classDatePicker.date = toUpdate.classDate
        classLocationText.text = toUpdate.classLocation
        confirmButton.setDarkButtonColor(toButtonNamed: confirmButton)
    }

    @IBAction func confirmButtonClicked(_ sender: Any) {
        guard let name = classNameText.text, !name.isEmpty, let address = classLocationText.text, !address.isEmpty, let toUpdateClass = updateClass else { return }
        InstructorCreateClassController.sharedInstructorCreateClassController.updateClass(with: toUpdateClass, newName: name, newDate: classDatePicker.date, newLocation: address)
        self.navigationController?.popToRootViewController(animated: true)
    }

}
