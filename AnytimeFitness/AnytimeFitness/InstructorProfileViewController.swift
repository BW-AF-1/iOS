//
//  InstructorProfileViewController.swift
//  AnytimeFitness
//
//  Created by Hannah Bain on 6/24/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class InstructorProfileViewController: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var insName: UILabel!
    @IBOutlet var insEmailLabel: UILabel!
    let db = Firestore.firestore()
    var userDocument: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetails()
    }
    
    func getUserDetails() {
        self.db.collection("instructors").whereField("uid", isEqualTo: UserController.currentUserUUID).getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting user doc: \(err)")
            } else {
                for document in snapshot!.documents {
                    if document == document {
                        self.userDocument = document.documentID
                    }
                }
                self.getUserName()
            }
        }
    }
    
    func getUserName() {
    db.collection("instructors").document(userDocument).getDocument(source: .cache) { (document, error) in
        if let document = document {
            guard let firstName = document.get("first_name") else { return }
            guard let lastName = document.get("last_name") else { return }
            guard let email = document.get("email") else { return }
            self.insName.text = "\(firstName)" + " \(lastName)"
            self.insEmailLabel.text = "\(email)"
        } else {
            print("Doc does not exist")
    
}
}
}
}
