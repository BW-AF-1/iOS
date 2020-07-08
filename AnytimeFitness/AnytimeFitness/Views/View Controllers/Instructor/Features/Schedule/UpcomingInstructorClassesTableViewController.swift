//
//  UpcomingInstructorClassesTableViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/25/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import CoreData

class UpcomingInstructorClassesTableViewController: UITableViewController {

    var classManagementController = ClassManagementController()

    lazy var fetchedResultsController: NSFetchedResultsController<NewClass> = {
        let fetchRequest = NSFetchRequest<NewClass>(entityName: "NewClass")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "classDateCD", ascending: true)
        ]
        let moc = CoreDataStack.shared.mainContext
        let instructor = NetworkController.sharedNetworkController.currentCDInstructor
        let classIDCD = instructor?.instructorID
        fetchRequest.predicate = NSPredicate(format: "instructorID == %i", classIDCD ?? 0)
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            NSLog("error fetching NewClass objects")
        }
        return frc

    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @IBAction func refreshData(_ sender: Any) {
        viewDidLoad()
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingInstructorClass", for: indexPath)

        let newClass = fetchedResultsController.object(at: indexPath)
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
            let newClass = fetchedResultsController.object(at: indexPath)
            let moc = CoreDataStack.shared.mainContext
            moc.delete(newClass)
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
        if segue.identifier == "ShowInstructorClass" {
            if let detailVC = segue.destination as? ManageInstructorClassConfirmViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                detailVC.updateClass = fetchedResultsController.object(at: indexPath)
            }
        }
    }

}

extension UpcomingInstructorClassesTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            break
        }
    }
}
