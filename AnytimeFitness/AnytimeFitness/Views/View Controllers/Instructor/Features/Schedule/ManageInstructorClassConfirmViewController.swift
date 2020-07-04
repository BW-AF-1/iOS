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

    var updateClass: NewClass?
    var classManagementController = ClassManagementController()


    override func viewDidLoad() {
        super.viewDidLoad()
        if let updateClass = updateClass {
            classNameText.text = updateClass.classNameCD
            classDatePicker.date = updateClass.classDateCD
            classLocationText.text = updateClass.classLocationCD
            confirmButton.setDarkButtonColor(toButtonNamed: confirmButton)
        }
    }

    @IBAction func confirmButtonClicked(_ sender: Any) {
        guard let name = classNameText.text, !name.isEmpty, let address = classLocationText.text, !address.isEmpty, let updateClass = updateClass else { return }
        classManagementController.updateInstructorClass(with: updateClass, name: name, address: address, newDate: classDatePicker.date)
        self.performSegue(withIdentifier: "showUpcomingClass", sender: self)
    }

}
