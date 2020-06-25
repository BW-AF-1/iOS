//
//  ClientSignUpViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ClientSignUpViewController: UIViewController {

    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.becomeFirstResponder()
    }
    
    @IBAction func createClient(_ sender: Any) {
        guard let firstName = firstName.text else { return }
        guard let lastName = lastName.text else { return }
        guard let email = email.text else { return }
        guard let phoneNumber = phoneNumber.text else { return }

        print(firstName, lastName, email, phoneNumber)
        
                Client(email: email,
                       firstName: firstName,
                    lastName: lastName,
                    phoneNumber: phoneNumber,
                    context: CoreDataStack.shared.mainContext)
                do {
                    try CoreDataStack.shared.mainContext.save()
                } catch {
                    NSLog("Error saving managed object context: \(error)")
        
            }
    }

}
