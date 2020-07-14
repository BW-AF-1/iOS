//
//  ClientSearchTableViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/28/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class ClientSearchTableViewController: UITableViewController {
    
    #warning("Need to create a local array to work with to avoid user weird categories and then branch off from there")
    
    let db = Firestore.firestore()
    
    static var fullClassDataArray: [Classes] = []
    static var documentArray: [String] = []
    
    var classCategoryArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAllClassesCategories()
    }
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    func fetchAllClassesCategories() {
        self.db.collection("classes").getDocuments { (snapshot, err) in
            if let err = err {
                print("error: \(err)")
            } else {
                for document in snapshot!.documents {
                    let currentDoc = document.documentID
                    ClientSearchTableViewController.self.documentArray.append(currentDoc)
                    print(ClientSearchTableViewController.self.documentArray)
                    guard let classCategory = document.get("classCategory") else { return }
                    guard let className = document.get("className") else { return }
                    guard let classLevel = document.get("classLevel") else { return }
                    guard let classLocation = document.get("classLocation") else { return }
                    guard let aboutClass = document.get("aboutClass") else { return }
                    guard let classAttendents = document.get("currentAttendents") else { return }
                    guard let capacityCount = document.get("capacityCount") else { return }
                    
                    ClientSearchTableViewController.self.fullClassDataArray.append(
                        Classes(
                            className: "\(className)",
                            classLevel: "\(classLevel)",
                            classLocation: "\(classLocation)",
                            classCategory: "\(classCategory)",
                            aboutClass: "\(aboutClass)",
                            currentAttendents: "\(classAttendents)",
                            capacityCount: "\(capacityCount)")
                    )
                }
            }
            self.pullOutData()
            self.tableView.reloadData()
        }
    }
    
    func pullOutData(){
        for categories in ClientSearchTableViewController.fullClassDataArray{
            classCategoryArray.append(categories.classCategory)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classCategoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCategories", for: indexPath)
        if classCategoryArray.count >= 1{
            cell.textLabel?.text = "Loading..."
        }
        run(after: 1) {
            cell.textLabel?.text = self.classCategoryArray[indexPath.row]
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchCategory" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            UserController.currentClassIndex = indexPath.row
        }
    }
    
}
