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
    @IBOutlet weak var classDescriptionText: UITextView!
    @IBOutlet weak var classNeedToKnowText: UITextView!
    @IBOutlet weak var classPriceText: UITextField!
    @IBOutlet weak var classLocationText: UITextField!
    @IBOutlet weak var confirmButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.setDarkButtonColor(toButtonNamed: confirmButton)

    }

    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
