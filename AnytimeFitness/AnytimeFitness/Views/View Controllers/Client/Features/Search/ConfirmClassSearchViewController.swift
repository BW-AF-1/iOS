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

    var confirmClass: NewClass?
    var classManagementController = ClassManagementController()

    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.setDarkButtonColor(toButtonNamed: confirmButton)
        view.setDarkBackground()

        guard let confirmClass = confirmClass else { return }
        classTitleText.text = confirmClass.classNameCD
        classTimeText.text = classManagementController.formatClassTime(with: confirmClass)
        classDateText.text = classManagementController.formatClassDate(with: confirmClass)
    }

    @IBAction func ConfirmButtonClicked(_ sender: Any) {
        guard let confirmClass = confirmClass else { return }
        classManagementController.createClientClass(with: confirmClass)
        classManagementController.updateClassCount(with: confirmClass)
        print("this is confirmed class with added client: \(confirmClass)")
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

}
