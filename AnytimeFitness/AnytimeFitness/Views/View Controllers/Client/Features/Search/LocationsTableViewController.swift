//
//  LocationsTableViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/29/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController {
    
    #warning("Instead of a single location we need to create a whole list of locations for that single category and branch off from there")
    
    var currentLocation: String = ""
    let staticArray = ClientSearchTableViewController.fullClassDataArray
    var locationsArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullOutLocations()
        print(UserController.currentClassIndex)
    }
    
    func pullOutLocations() {
        currentLocation = staticArray[UserController.currentClassIndex].classLocation
        locationsArray.append(currentLocation)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationsCell", for: indexPath)
        cell.textLabel?.text = locationsArray[indexPath.row]
        return cell
    }
}
