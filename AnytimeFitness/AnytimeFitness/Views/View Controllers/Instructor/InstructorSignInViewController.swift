//
//  InstructorSignInViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/25/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import CoreData

class InstructorSignInViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var errorLabel: UILabel!

    var instructorAuth: InstructorRepresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkController.sharedNetworkController.fetchAllInstructors()
        NetworkController.sharedNetworkController.fetchCDInstructor()
        errorLabel.alpha = 0
    }
    
    @IBAction func signInTapped(_ sender: Any){
        guard let email = email.text, let password = password.text else {
            self.errorLabel.alpha = 1
            return }

        let instructorAuth = InstructorRepresentation(email: email, password: password)

        NetworkController.sharedNetworkController.loginInstructor(with: instructorAuth) { (error) in
            if let error = error {
                print("Error for instructor logging in: \(error)")
                DispatchQueue.main.async {
                self.errorLabel.alpha = 1
                }
                return
            }
            DispatchQueue.main.async {
                self.errorLabel.alpha = 0
                self.performSegue(withIdentifier: "instructorMain", sender: self)
            }

        }
}
}
