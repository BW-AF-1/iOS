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

    var clientAuth: ClientRepresentation?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        guard let email = email.text, let password = password.text else { return }

        let clientAuth = ClientRepresentation(email: email, password: password)

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                self.errorLabel.alpha = 1
                return
            } else {
                self.errorLabel.alpha = 0
                NetworkController.sharedNetworkController.loginClient(with: clientAuth) { (error) in
                if let error = error {
                    print("Error for client logging in: \(error)")
                }
                 DispatchQueue.main.async {
                self.performSegue(withIdentifier: "clientHome", sender: self)
                }
            }
        }
        
    }
}
}
