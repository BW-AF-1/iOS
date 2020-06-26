//
//  InstructorSignUpViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class InstructorSignUpViewController: UIViewController {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var errorLabel: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        firstName.becomeFirstResponder()
    }
    
    @IBAction func saveInstructor(_ sender: Any) {
        guard let firstName = firstName.text else { return }
        guard let lastName = lastName.text else { return }
        guard let email = email.text else { return }
        guard let password = password.text else { return }

        
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                self.errorLabel.alpha = 1
                print(error)
            } else {
                
                let db = Firestore.firestore()
                
                db.collection("instructors").addDocument(data: ["first_name": firstName, "last_name": lastName, "uid": result!.user.uid]) { (error) in
                    
                    if error != nil {
                        print(error)
                    }
                    self.errorLabel.alpha = 0
                    self.performSegue(withIdentifier: "instructorSignIn", sender: self)
                }
            }
        }


}
}
