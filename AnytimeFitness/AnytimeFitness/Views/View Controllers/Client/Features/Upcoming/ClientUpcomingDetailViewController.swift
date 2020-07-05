//
//  ClientUpcomingDetailViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 7/4/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ClientUpcomingDetailViewController: UIViewController {
    
    let db = Firestore.firestore()
    let staticArray = UpcomingClassesTableViewController.fullClassDataArray
    
    @IBOutlet var classNameLabel: UILabel!
    @IBOutlet var classLocationLabel: UILabel!
    @IBOutlet var classCategoryLabel: UILabel!
    @IBOutlet var classLevelLabel: UILabel!
    @IBOutlet var aboutClassView: UITextView!
    @IBOutlet var currentAttendentsLabel: UILabel!
    @IBOutlet var availableSpotsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
    }
    @IBAction func cancelClassReservationLabel(_ sender: Any) {
        dismiss(animated: true) {
            print("Dismissed")
        }
    }
    
    func setUpViews() {
        classNameLabel.text = staticArray[UserController.currentClassIndex].className
        classLocationLabel.text = staticArray[UserController.currentClassIndex].classLocation
        classCategoryLabel.text = staticArray[UserController.currentClassIndex].classCategory
        classLevelLabel.text = staticArray[UserController.currentClassIndex].classLevel
        aboutClassView.text = staticArray[UserController.currentClassIndex].aboutClass
        currentAttendentsLabel.text = staticArray[UserController.currentClassIndex].currentAttendents
        availableSpotsLabel.text = addStringsAsInts(string1: staticArray[UserController.currentClassIndex].capacityCount, string2: staticArray[UserController.currentClassIndex].currentAttendents)
    }
    
    func addStringsAsInts(string1: String, string2: String) -> String {
        let myStringInt = Int(string1)! - Int(string2)!
        if myStringInt == 0{
            return String(myStringInt) + " spot"
        } else{
            return String(myStringInt) + " spots"
        }
    }
    
    func deleteFromFirebaseArray() {
        let arrayRef = db.collection("classes").document()
        arrayRef.updateData([
            "attendentsArray": FieldValue.arrayRemove(["current uuid"])
        ])
    }
}
