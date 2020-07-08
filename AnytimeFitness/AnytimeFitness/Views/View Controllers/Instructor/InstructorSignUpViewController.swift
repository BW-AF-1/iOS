//
//  InstructorSignUpViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import CoreData

class InstructorSignUpViewController: UIViewController {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var errorLabel: UILabel!

    let networkController = NetworkController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        firstName.becomeFirstResponder()
    }
    
    @IBAction func saveInstructor(_ sender: Any) {
        guard let email = email.text, let password = password.text else {
            self.errorLabel.alpha = 1
            return }

        let instructor = InstructorRepresentation(email: email, password: password)

        self.networkController.registerInstructor(with: instructor) { (error) in
            if let error = error {
                print("Error for instructor registering: \(error)")
            }
            DispatchQueue.main.async {
                self.errorLabel.alpha = 0
                self.performSegue(withIdentifier: "instructorSignIn", sender: self)
            }
}
}
}

