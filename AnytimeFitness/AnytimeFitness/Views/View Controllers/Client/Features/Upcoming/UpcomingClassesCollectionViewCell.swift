//
//  UpcomingClassesCollectionViewCell.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class UpcomingClassesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classNameText: UILabel!
    @IBOutlet weak var classDateText: UILabel!
    @IBOutlet weak var classTimeText: UILabel!
    @IBOutlet weak var rescheduleButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    @IBAction func rescheduleButtonClicked(_ sender: Any) {
    }

    @IBAction func deleteButtonClicked(_ sender: Any) {
    }

}
