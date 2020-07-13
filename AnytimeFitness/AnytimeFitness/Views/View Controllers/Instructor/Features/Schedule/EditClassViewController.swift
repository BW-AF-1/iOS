//
//  EditClassViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 7/6/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class EditClassViewController: UIViewController {
    
    #warning("Does not push to the data base with changes yet")
    
    var className: String = ""
    var classLevel: String = ""
    var classCategory: String = ""
    var classLocation: String = ""
    var classAbout: String = ""
    
    @IBOutlet var classNameField: UITextField!
    @IBOutlet var classLevelField: UITextField!
    @IBOutlet var classCategoryField: UITextField!
    @IBOutlet var classLocationField: UITextField!
    @IBOutlet var classCapacityField: UITextField!
    @IBOutlet var aboutClassView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        classNameField.placeholder = className
        classLevelField.placeholder = classLevel
        classCategoryField.placeholder = classCategory
        classLocationField.placeholder = classLocation
        aboutClassView.textColor = .lightGray
        aboutClassView.text = classAbout
    }
    
    
    @IBAction func saveEditClassPushed(_ sender: Any) {
        dismiss(animated: true) {
            print("Saved Class")
        }
    }
    
}
