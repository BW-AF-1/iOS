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

    var updateClass: NewClass?
    var classManagementController = ClassManagementController()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let updateClass = updateClass {
            classImageView.setDarkBackground(toImageNamed: updateClass.classTypeCD)
            classNameText.text = updateClass.classNameCD
            classTimeText.text = classManagementController.formatClassTime(with: updateClass)
            classDateText.text = classManagementController.formatClassDate(with: updateClass)
            classLocationText.text = updateClass.classLocationCD
            classTypeText.text = updateClass.classTypeCD
            classDurationText.text = ("\(updateClass.classDurationCD) mins")
            classIntensityText.text = updateClass.classLevelCD
            reservedNumberText.text = "\(updateClass.classCurrentSizeCD)/ \(updateClass.classMaxSizeCD)"
            remainingNumberText.text = "\(updateClass.classMaxSizeCD - updateClass.classCurrentSizeCD) spot(s)"
        }
        exitButton.setDarkButtonColor(toButtonNamed: exitButton)
    }

    @IBAction func exitButtonClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }


}
