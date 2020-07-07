//
//  ScheduleTableViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/28/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class ScheduleTableViewController: UITableViewController {
    
    @IBOutlet var classNameLabel: UILabel!
    
    let db = Firestore.firestore()
    
    var classesArray: [String] = []
    var classNameArray: [String] = []
    var classLevelArray: [String] = []
    var classCategoryArray: [String] = []
    var classLocationArray: [String] = []
    var classAboutArray: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    func fetchAllAvailableClasses() {
        self.db.collection("classes").whereField("uid", isEqualTo: UserController.currentUserUUID).getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    if document == document {
                        let currentDoc = document.documentID
                        self.classesArray.append(currentDoc)
                        let classNames = self.db.collection("classes").document(currentDoc)
                        classNames.getDocument(source: .cache) { (document, error) in
                            if let document = document {
                                guard let className = document.get("className") else { return }
                                self.classNameArray.append("\(className)")
                                guard let classLevel = document.get("classLevel") else { return }
                                self.classLevelArray.append("\(classLevel)")
                                guard let classCategory = document.get("classCategory") else { return }
                                self.classCategoryArray.append("\(classCategory)")
                                guard let classLocation = document.get("classLocation") else { return }
                                self.classLocationArray.append("\(classLocation)")
                                guard let classAbout = document.get("aboutClass") else { return }
                                self.classAboutArray.append("\(classAbout)")
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func removeAllLocalArrayInfo(){
        classesArray.removeAll()
        classNameArray.removeAll()
        classLevelArray.removeAll()
        classCategoryArray.removeAll()
        classLocationArray.removeAll()
        classAboutArray.removeAll()
    }

    override func viewWillAppear(_ animated: Bool) {
        removeAllLocalArrayInfo()
        fetchAllAvailableClasses()
        tableView.reloadData()
    }
    
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return classesArray.count
}


 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "classNames", for: indexPath)
    if classesArray.count >= 1 {
    cell.textLabel?.text = "Loading..."
    } else {
        cell.textLabel?.text = nil
    }
    run(after: 3) {
        cell.textLabel?.text = self.classNameArray[indexPath.row]
    }
    return cell

 }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ClassReview" {
            guard let classDetailsVC = segue.destination as? ClassReviewViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
                classDetailsVC.className = classNameArray[indexPath.row]
                classDetailsVC.classLevel = classLevelArray[indexPath.row]
                classDetailsVC.classCategory = classCategoryArray[indexPath.row]
                classDetailsVC.classLocation = classLocationArray[indexPath.row]
                classDetailsVC.classAbout = classAboutArray[indexPath.row]
        }
    }
}

