//
//  InstructorSignInViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/25/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseAuth

class InstructorSignInViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var errorLabel: UILabel!

    var instructorAuth: InstructorRepresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
    }
    
    @IBAction func signInTapped(_ sender: Any){
        guard let email = email.text, let password = password.text else { return }

        let instructorAuth = InstructorRepresentation(email: email, password: password)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                self.errorLabel.alpha = 1
                return
            } else {
                self.errorLabel.alpha = 0
                NetworkController.sharedNetworkController.loginInstructor(with: instructorAuth) { (error) in
                    if let error = error {
                        print("Error for instructor logging in: \(error)")
                    }
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "instructorMain", sender: self)
                    }
                }
            }

        }
    }
}
