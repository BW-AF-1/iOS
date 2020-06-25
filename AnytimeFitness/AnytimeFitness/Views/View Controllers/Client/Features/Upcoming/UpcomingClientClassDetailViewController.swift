//
//  UpcomingClientClassDetailViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/24/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class UpcomingClientClassDetailViewController: UIViewController {
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var classNameText: UILabel!
    @IBOutlet weak var classDateText: UILabel!
    @IBOutlet weak var classTimeText: UILabel!
    @IBOutlet weak var classLocationText: UILabel!
    @IBOutlet weak var classTypeText: UILabel!
    @IBOutlet weak var classDurationText: UILabel!

    @IBOutlet weak var classIntensityText: UILabel!

    @IBOutlet weak var reservedNumberText: UILabel!
    @IBOutlet weak var exitButton: UIButton!

    @IBOutlet weak var remainingNumberText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.setDarkButtonColor(toButtonNamed: exitButton)
        classImageView.setDarkBackground()

    }
    @IBAction func exitButtonClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }


}
