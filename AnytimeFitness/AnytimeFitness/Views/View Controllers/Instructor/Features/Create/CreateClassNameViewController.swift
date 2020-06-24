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
    @IBOutlet weak var classDescriptionText: UITextView!
    @IBOutlet weak var classNeedToKnowText: UITextView!
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        classNeedToKnowText.layer.borderWidth = 1
        classNeedToKnowText.layer.borderColor = UIColor.black.cgColor
        classDescriptionText.layer.borderWidth = 1
        classDescriptionText.layer.borderColor = UIColor.black.cgColor
        nextButton.setDarkButtonColor(toButtonNamed: nextButton)
    }

}
