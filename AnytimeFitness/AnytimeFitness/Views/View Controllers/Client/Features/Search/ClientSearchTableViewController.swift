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
    
    let db = Firestore.firestore()
    
    var classCategoryArray: [String] = []
    var totalCount: Int = 0

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
                print("error")
            } else {
                for document in snapshot!.documents {
                    guard let classCategory = document.get("classCategory") else { return }
                    self.classCategoryArray.append("\(classCategory)")
                    print(classCategory)
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        run(after: 1) {
            print(self.classCategoryArray)
            print(self.classCategoryArray.count)
            self.totalCount = self.classCategoryArray.count
        }
        print(totalCount)
        return totalCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCategories", for: indexPath)
        cell.textLabel?.text = "Hello does this work?"
        run(after: 4) {
            cell.textLabel?.text = self.classCategoryArray[indexPath.row]
        }
        return cell
    }
    
}
