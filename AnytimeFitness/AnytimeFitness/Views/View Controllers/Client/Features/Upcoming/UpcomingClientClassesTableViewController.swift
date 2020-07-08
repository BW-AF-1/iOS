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
          //  print("list of currentClientClasses: \(currentClientClasses)")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let currentClientInit = NetworkController.sharedNetworkController.currentCDClient
        guard let currentClients = currentClientInit else { return }
        if let classArray = currentClients.registeredClasses!.allObjects as? [NewClass], !classArray.isEmpty, classArray.count > 0 {
                        currentClientClasses = classArray
                        tableView.reloadData()
                } else {
                    return
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
        let newClass = currentClientClasses[indexPath.row]

        cell.textLabel?.text = newClass.classNameCD
        cell.detailTextLabel?.text = classManagementController.formatClassTime(with: newClass)
        let imageView = UIImage(named: newClass.classTypeCD)
        let blackCover: UIView = UIView(frame: cell.contentView.frame)
        blackCover.backgroundColor = UIColor.black
        blackCover.layer.opacity = 0.80
        cell.backgroundView = UIImageView(image: imageView)
        cell.backgroundView?.contentMode = .scaleAspectFill
        cell.backgroundView?.addSubview(blackCover)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let newClass = currentClientClasses[indexPath.row]
                    let moc = CoreDataStack.shared.mainContext
            currentClient?.removeFromRegisteredClasses(newClass)
            classManagementController.deleteClassCount(with: newClass)
            classManagementController.deleteClientClass(with: newClass)
            currentClientClasses.removeAll{ $0 == newClass }
                    do {
                        try moc.save()
                    } catch {
                        moc.reset()
                        NSLog("Error saving managed object context: \(error)")
                    }
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
