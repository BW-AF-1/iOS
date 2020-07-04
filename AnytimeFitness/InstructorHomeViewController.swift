//
//  InstructorHomeViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 7/3/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class InstructorHomeViewController: UIViewController {

        @IBOutlet weak var logoutButton: UIButton!
        @IBOutlet weak var welcomeText: UILabel!
        @IBOutlet weak var welcomeDes: UILabel!

        override func viewDidLoad() {
            super.viewDidLoad()
            view.setDarkBackground()
        }
    @IBAction func logoutClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "InstructorLogout", sender: self)
    }

    }


