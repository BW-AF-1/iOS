//
//  ConfirmClassSearchViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ConfirmClassSearchViewController: UIViewController {
    @IBOutlet weak var classTitleText: UILabel!
    @IBOutlet weak var classDateText: UILabel!
    @IBOutlet weak var classTimeText: UILabel!
    @IBOutlet weak var confirmButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.setDarkButtonColor(toButtonNamed: confirmButton)
        view.setDarkBackground()
    }

    @IBAction func ConfirmButtonClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
