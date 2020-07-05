//
//  UpcomingClassesTableViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/29/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseFirestore

class UpcomingClassesTableViewController: UITableViewController {
    
    var classNameArray: [String] = []
    static var fullClassDataArray: [Classes] = []
    var upcomingClassesDocArray: [String] = []
    
    let db = Firestore.firestore()
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    func removeAllLocalArrayInfo() {
        UpcomingClassesTableViewController.fullClassDataArray.removeAll()
        upcomingClassesDocArray.removeAll()
        classNameArray.removeAll()
    }
    
    func fetchUserClasses() {
        self.db.collection("classes").whereField("attendentsArray", arrayContains: UserController.currentUserUUID).getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else{
                for document in snapshot!.documents {
                    if document == document {
                        let currentDoc = document.documentID
                        self.upcomingClassesDocArray.append(currentDoc)
                        let classesNames = self.db.collection("classes").document(currentDoc)
                        classesNames.getDocument(source: .cache) {
                            (document, error) in
                            if let document = document {
                                guard let classCategory = document.get("classCategory") else { return }
                                guard let className = document.get("className") else { return }
                                guard let classLevel = document.get("classLevel") else { return }
                                guard let classLocation = document.get("classLocation") else { return }
                                guard let aboutClass = document.get("aboutClass") else { return }
                                guard let classAttendents = document.get("currentAttendents") else { return }
                                guard let capacityCount = document.get("capacityCount") else { return }
                                
                                UpcomingClassesTableViewController.self.fullClassDataArray.append(Classes(className: "\(className)", classLevel: "\(classLevel)", classLocation: "\(classLocation)", classCategory: "\(classCategory)", aboutClass: "\(aboutClass)", currentAttendents: "\(classAttendents)", capacityCount: "\(capacityCount)"))
                                
                                self.classNameArray.append("\(className)")
                            }
                        }
                        self.run(after: 3) {
                            self.tableView.reloadData()
                            
                        }
                    }
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        removeAllLocalArrayInfo()
        fetchUserClasses()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return UpcomingClassesTableViewController.fullClassDataArray.count
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingClassesCell", for: indexPath)
            if UpcomingClassesTableViewController.fullClassDataArray.count >= 1 {
                cell.textLabel?.text = "Loading..."
                cell.textLabel?.text = self.classNameArray[indexPath.row]
            } else {
                cell.textLabel?.text = "No upcoming classes..."
            }
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toClassDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            UserController.currentClassIndex = indexPath.row
            print(UserController.currentClassIndex)
        }
    }
    
}
