//
//  CreateClassViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/28/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseFirestore


class CreateClassViewController: UIViewController {
    @IBOutlet var className: UITextField!
    @IBOutlet var classLevel: UITextField!
    @IBOutlet var classCategory: UITextField!
    @IBOutlet var classLocation: UITextField!
    @IBOutlet var aboutClass: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutClass.text = ""
        aboutClass.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func addClass(_ sender: Any) {
        guard let className = className.text else { return }
        guard let classLevel = classLevel.text else { return }
        guard let classCategory = classCategory.text else { return }
        guard let classLocation = classLocation.text else { return }
        guard let aboutClass = aboutClass.text else { return }

        
        let db = Firestore.firestore()
        
        db.collection("classes").addDocument(data: ["className": className, "classLevel": classLevel, "classCategory": classCategory, "classLocation": classLocation, "aboutClass": aboutClass, "uid": UserController.currentUserUUID]) { (error) in
        
        if error != nil {
        print(error)
        }
        self.performSegue(withIdentifier: "classCreationSuccess", sender: self)
        }
    }
}
