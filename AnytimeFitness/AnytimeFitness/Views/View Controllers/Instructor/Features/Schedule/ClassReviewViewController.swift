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
        classNameLabel.text = ""
        classLevelLabel.text = ""
        classCategoryLabel.text = ""
        classLocationLabel.text = ""
        classAboutLabel.text = ""
    }

}
