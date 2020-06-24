//
//  CreateClassTimeDetailsViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class CreateClassTimeDetailsViewController: UIViewController {

    @IBOutlet weak var classLocationText: UITextField!

    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

            nextButton.setDarkButtonColor(toButtonNamed: nextButton)
    }


}
