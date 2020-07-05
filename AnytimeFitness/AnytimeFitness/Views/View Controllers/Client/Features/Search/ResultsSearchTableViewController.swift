//
//  ResultsSearchTableViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/29/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ResultsSearchTableViewController: UITableViewController {
    
    var currentName: String = ""
    let staticArray = ClientSearchTableViewController.fullClassDataArray
    var namesArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullOutNames()
        print(UserController.currentClassIndex)
    }
    
    func pullOutNames() {
        currentName = staticArray[UserController.currentClassIndex].className
        namesArray.append(currentName)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return namesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classNameCell", for: indexPath)
        
        cell.textLabel?.text = namesArray[indexPath.row]
        
        return cell
    }
    
}
