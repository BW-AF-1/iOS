//
//  CompleteClassViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/21/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class CompleteClassViewController: UIViewController {

    @IBOutlet weak var viewClassButton: UIButton!
    @IBOutlet weak var addClassButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setDarkBackground()
        view.setDarkButtonColor(toButtonNamed: viewClassButton)
        view.setDarkButtonColor(toButtonNamed: addClassButton)
    }

    @IBAction func addClassButtonClicked(_ sender: Any) {
            self.navigationController?.popToRootViewController(animated: true)
    }

}
