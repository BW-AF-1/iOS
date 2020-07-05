//
//  ClientProfileViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/28/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class ClientProfileViewController: UIViewController {
    
    @IBOutlet var clientProfileImage: UIImageView!
    @IBOutlet var clientName: UILabel!
    @IBOutlet var clientEmail: UILabel!
    
    let db = Firestore.firestore()
    var userDocument: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clientEmail.text = ""
        clientName.text = ""
        getUserDetails()
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        UserController.currentUserUUID = ""
    }
    func getUserDetails() {
        self.db.collection("clients").whereField("uid", isEqualTo: UserController.currentUserUUID).getDocuments { (snapshot, err) in
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
        db.collection("clients").document(userDocument).getDocument(source: .cache) { (document, error) in
            if let document = document {
                guard let firstName = document.get("first_name") else { return }
                guard let lastName = document.get("last_name") else { return }
                guard let email = document.get("email") else { return }
                self.clientName.text = "\(firstName)" + " \(lastName)"
                self.clientEmail.text = "\(email)"
            } else {
                print("Doc does not exist")
                
            }
        }
    }
    
}
