//
//  ClientFavoritesViewController.swift
//  AnytimeFitness
//
//  Created by Hannah Bain on 6/24/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ClientFavoritesViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
         @IBOutlet weak var welcomeText: UILabel!
         @IBOutlet weak var welcomeDes: UILabel!

         override func viewDidLoad() {
             super.viewDidLoad()
             view.setDarkBackground()
         }
     @IBAction func logoutClicked(_ sender: UIButton) {
         performSegue(withIdentifier: "ClientLogout", sender: self)
     }

}
