//
//  ClientSignUpViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import CoreData

class ClientSignUpViewController: UIViewController {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.becomeFirstResponder()
        errorLabel.alpha = 0
    }
    
    @IBAction func createClient(_ sender: Any) {
        guard let email = email.text else { return }
        guard let password = password.text else { return }

        let client = ClientRepresentation(email: email, password: password)


        NetworkController.sharedNetworkController.registerClient(with: client) { (error) in
            if let error = error {
                print("Error for client registering: \(error)")
            }
            DispatchQueue.main.async {
                self.errorLabel.alpha = 0
                self.performSegue(withIdentifier: "clientSignIn", sender: self)
            }
        }
    }

}
