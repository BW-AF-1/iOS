//
//  UpcomingInstructorClassesCollectionViewCell.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class UpcomingInstructorClassesCollectionViewCell: UICollectionViewCell {
    var classes: InstructorCreateClassController.ExampleClassType?
    var newClasses: NewClass? {
        didSet {
            imageView.image = UIImage(contentsOfFile: newClasses?.classTypeCD ?? "MainFitness")
            classNameText.text = newClasses?.classNameCD
            classDateText.text = newClasses?.classDateCD?.description
            classTimeText.text = newClasses?.classDateCD?.description
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classNameText: UILabel!
    @IBOutlet weak var classDateText: UILabel!
    @IBOutlet weak var classTimeText: UILabel!
    @IBOutlet weak var rescheduleButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    @IBAction func rescheduleButtonClicked(_ sender: Any) {

    }

    @IBAction func deleteButtonClicked(_ sender: UpcomingClassesCollectionViewCell) {
        if classes != nil {
            InstructorCreateClassController.sharedInstructorCreateClassController.deletedClasses(with: classes!)
        } else {
            return
        }
        print("New array after deletion is: \(InstructorCreateClassController.sharedInstructorCreateClassController.exampleClass)")
         }
}
