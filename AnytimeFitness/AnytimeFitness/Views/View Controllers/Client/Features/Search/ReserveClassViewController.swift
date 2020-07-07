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
    var newAttendantsCount: Int = 0
    
    @IBOutlet var currentAddendentsLabel: UILabel!
    @IBOutlet var availableSpotsLabel: UILabel!
    @IBOutlet var classNameLabel: UILabel!
    @IBOutlet var classLocationLabel: UILabel!
    @IBOutlet var classCategoryLabel: UILabel!
    @IBOutlet var classLevelLabel: UILabel!
    @IBOutlet var aboutClassLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewInit()
        setUpView()
    }
    
    func setUpView(){

        classNameLabel.text = staticArray[UserController.currentClassIndex].className
        classLocationLabel.text = staticArray[UserController.currentClassIndex].classLocation
        classCategoryLabel.text = staticArray[UserController.currentClassIndex].classCategory
        classLevelLabel.text = staticArray[UserController.currentClassIndex].classLevel
        currentAddendentsLabel.text = staticArray[UserController.currentClassIndex].currentAttendents
        aboutClassLabel.text = staticArray[UserController.currentClassIndex].aboutClass
        availableSpotsLabel.text = addStringsAsInts(string1: staticArray[UserController.currentClassIndex].capacityCount, string2: staticArray[UserController.currentClassIndex].currentAttendents)
    }
    
    func viewInit(){
        classNameLabel.text = "Loading..."
        classLocationLabel.text = "Loading..."
        classCategoryLabel.text = "Loading..."
        classLevelLabel.text = "Loading..."
        currentAddendentsLabel.text = "Loading..."
        aboutClassLabel.text = "Loading..."
        availableSpotsLabel.text = "Loading..."
    }
    
    func addToFireBaseArray() {
        let arrayRef = db.collection("classes").document(staticDocArray[UserController.currentClassIndex])
        arrayRef.updateData([
            "attendentsArray": FieldValue.arrayUnion(["\(UserController.currentUserUUID)"])
        ])
    }
    
    func changeAttendantCount() {
        let currentCapacityCount = staticArray[UserController.currentClassIndex].capacityCount
        let currentAttendantsCount = staticArray[UserController.currentClassIndex].currentAttendents
        
        let intCapCount: Int = Int(currentCapacityCount)!
        let intAttenantsCount: Int = Int(currentAttendantsCount)!
        
        if intAttenantsCount < intCapCount{
            newAttendantsCount = intAttenantsCount + 1
            
            let dataRef = db.collection("classes").document(staticDocArray[UserController.currentClassIndex])
            dataRef.updateData([
                "currentAttendents" : "\(newAttendantsCount)"
            ])
        } else {
            return
        }
    }
    
    #warning("need to implement to avoid UX issues")
    func checkIfAlreadyEnrolled(){
        // If uuid is in the attendants array already show error
    }
    
    func addStringsAsInts(string1: String, string2: String) -> String {
        let myStringInt = Int(string1)! - Int(string2)!
        if myStringInt == 0{
            return String(myStringInt) + " spot"
        } else{
            return String(myStringInt) + " spots"
        }
    }
    
    @IBAction func reserveClassTapped(_ sender: Any) {
        addToFireBaseArray()
        changeAttendantCount()
        
        dismiss(animated: true) {
            print("Complete")
        }
    }
}
