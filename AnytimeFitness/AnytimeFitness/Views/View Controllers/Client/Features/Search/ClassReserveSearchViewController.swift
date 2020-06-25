//
//  ClassReserveSearchViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ClassReserveSearchViewController: UIViewController {
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var classNameText: UILabel!
    @IBOutlet weak var classDateText: UILabel!
    @IBOutlet weak var classTimeText: UILabel!
    @IBOutlet weak var classLocationText: UILabel!
    @IBOutlet weak var reservedRatio: UILabel!
    @IBOutlet weak var remainingNumber: UILabel!
    @IBOutlet weak var reserveButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        reserveButton.setDarkButtonColor(toButtonNamed: reserveButton)
        classImageView.setBackground()
    }

}
