//
//  ReserveClassViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/29/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ReserveClassViewController: UIViewController {
    
    let staticArray = ClientSearchTableViewController.fullClassDataArray
    let db = Firestore.firestore()
    let staticDocArray = ClientSearchTableViewController.documentArray
    
    @IBOutlet var currentAddendentsLabel: UILabel!
    @IBOutlet var availableSpotsLabel: UILabel!
    @IBOutlet var classNameLabel: UILabel!
    @IBOutlet var classLocationLabel: UILabel!
    @IBOutlet var classCategoryLabel: UILabel!
    @IBOutlet var classLevelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView(){
        classNameLabel.text = staticArray[UserController.currentClassIndex].className
        classLocationLabel.text = staticArray[UserController.currentClassIndex].classLocation
        classCategoryLabel.text = staticArray[UserController.currentClassIndex].classCategory
        classLevelLabel.text = staticArray[UserController.currentClassIndex].classLevel
        currentAddendentsLabel.text = staticArray[UserController.currentClassIndex].currentAttendents
        availableSpotsLabel.text = addStringsAsInts(string1: staticArray[UserController.currentClassIndex].capacityCount, string2: staticArray[UserController.currentClassIndex].currentAttendents)
        
    }
    
    func addToFireBaseArray() {
        let arrayRef = db.collection("classes").document(staticDocArray[UserController.currentClassIndex])
        arrayRef.updateData([
            "attendentsArray": FieldValue.arrayUnion(["\(UserController.currentUserUUID)"])
        ])
        
    }
    
    func addStringsAsInts(string1: String, string2: String) -> String {
        let myStringInt = Int(string1)! - Int(string2)!
        
        return String(myStringInt)
    }
    @IBAction func reserveClassTapped(_ sender: Any) {
        addToFireBaseArray()
        
        dismiss(animated: true) {
            print("Complete")
        }
    }
}
