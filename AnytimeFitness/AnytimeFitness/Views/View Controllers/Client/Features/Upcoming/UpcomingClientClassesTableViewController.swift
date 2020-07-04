//
//  UpcomingClientClassesTableViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/26/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import CoreData

class UpcomingClientClassesTableViewController: UITableViewController {

var classManagementController = ClassManagementController()
let currentClient = NetworkController.sharedNetworkController.currentCDClient
var currentClientClasses: [NewClass] = [] {
        didSet {
            print("list of currentClientClasses: \(currentClientClasses)")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
             guard let currentClient = currentClient else { return }
                if let classArray = currentClient.registeredClasses!.allObjects as? [NewClass], !classArray.isEmpty {
                    for element in classArray {
                       if currentClientClasses.contains(element) { return } else {
                        currentClientClasses.append(element)
                       }
                        tableView.reloadData()
                    }
                }
    }

    @IBAction func refreshData(_ sender: Any) {
        tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentClientClasses.count > 0 {
        return currentClientClasses.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingClientClass", for: indexPath)

      // let newClass = fetchedResultsController.object(at: indexPath)
        let newClass = currentClientClasses[indexPath.row]

        cell.textLabel?.text = newClass.classNameCD
        cell.detailTextLabel?.text = classManagementController.formatClassTime(with: newClass)
        cell.setDarkBackground(toImageNamed: newClass.classTypeCD)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let newClass = currentClientClasses[indexPath.row]
                    let moc = CoreDataStack.shared.mainContext
            currentClient?.removeFromRegisteredClasses(newClass)
            classManagementController.deleteClassCount(with: newClass)
                    do {
                        try moc.save()
                        tableView.reloadData()
                    } catch {
                        moc.reset()
                        NSLog("Error saving managed object context: \(error)")
                    }
                }
            }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showClientDetailClass" {
               if let detailVC = segue.destination as? UpcomingClientClassDetailViewController,
                   let indexPath = tableView.indexPathForSelectedRow {
                detailVC.updateClass = currentClientClasses[indexPath.row]
               }
           }
    }

}
