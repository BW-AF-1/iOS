//
//  ManageInstructorScheduleTableViewCell.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/23/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ManageInstructorScheduleTableViewCell: UITableViewCell {

    var classCell: ExampleClassType? 

    @IBOutlet weak var classTimeText: UILabel!
    @IBOutlet weak var classNameText: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    @IBAction func deleteButtonClicked(_ sender: Any) {

    }

}
