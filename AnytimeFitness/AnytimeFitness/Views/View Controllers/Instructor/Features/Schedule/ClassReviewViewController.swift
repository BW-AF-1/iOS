//
//  ClassReviewViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/28/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class ClassReviewViewController: UIViewController {
        
    var className: String = ""
    var classLevel: String = ""
    var classCategory: String = ""
    var classLocation: String = ""
    var classAbout: String = ""


    @IBOutlet var classNameLabel: UILabel!
    @IBOutlet var classLevelLabel: UILabel!
    @IBOutlet var classCategoryLabel: UILabel!
    @IBOutlet var classLocationLabel: UILabel!
    @IBOutlet var classAboutLabel: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
    }
    
    func setUpViews() {
        classNameLabel.text = className
        classLevelLabel.text = classLevel
        classCategoryLabel.text = classCategory
        classLocationLabel.text = classLocation
        classAboutLabel.text = classAbout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editClassSegue"{
            guard let editClassVC = segue.destination as? EditClassViewController else { return }
            editClassVC.className = className
            editClassVC.classLevel = classLevel
            editClassVC.classCategory = classCategory
            editClassVC.classLocation = classLocation
            editClassVC.classAbout = classAbout

        }
    }

}
