//
//  ClassOverviewViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ClassOverviewSearchViewController: UIViewController {

    @IBOutlet weak var classImageView: UIImageView!

    @IBOutlet weak var classTitle: UILabel!
    @IBOutlet weak var aboutClassText: UITextView!

    @IBOutlet weak var classCostText: UILabel!

    @IBOutlet weak var classLocationText: UILabel!

    @IBOutlet weak var viewScheduleButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewScheduleButton.setDarkButtonColor(toButtonNamed: viewScheduleButton)
        classImageView.setBackground()

    }



}
