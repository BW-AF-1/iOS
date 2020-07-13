//
//  InstructorSignInViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/25/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class InstructorSignInViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    let db = Firestore.firestore()
    var state: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        email.delegate = self
        password.delegate = self
    }
    
    @IBAction func signInTapped(_ sender: Any){
        #warning("Need to auth user from instructor to client")
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (result, error) in
            if error != nil {
                self.errorLabel.alpha = 1
                return
            } else {
                self.errorLabel.alpha = 0
                UserController.currentUserUUID = "\(result!.user.uid)"
                print("\(result!.user.uid)")
                self.performSegue(withIdentifier: "instructorMain", sender: self)
            }
        }
        
    }
    
}

extension InstructorSignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
