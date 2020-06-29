//
//  ClientSignInViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/25/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import FirebaseAuth

class ClientSignInViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var errorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (result, error) in
            if error != nil{
                self.errorLabel.alpha = 1
                return
            } else {
                self.errorLabel.alpha = 0
                UserController.currentUserUUID = "\(result!.user.uid)"
                print("\(result!.user.uid)")
                self.performSegue(withIdentifier: "clientHome", sender: self)
            }
        }
        
    }
}
