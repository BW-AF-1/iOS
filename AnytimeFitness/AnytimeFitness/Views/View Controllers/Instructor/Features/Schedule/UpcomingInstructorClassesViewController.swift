//
//  UpcomingInstructorClassesViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import CoreData

class UpcomingInstructorClassesViewController: UIViewController,  CollectionViewFetchedResultsControllerDelegate {

    @IBOutlet weak var UpcomingInstructorClassesCollectionView: UICollectionView!

    lazy var fetchedResultsController: NSFetchedResultsController<NewClass> = {
        let fetchRequest = NSFetchRequest<NewClass>(entityName: "NewClass")
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = CollectionViewFetchedResultsControllerDelegate()
        do {
            try frc.performFetch()
        } catch {
            NSLog("error fetching NewClass objects")
        }
        return frc

    }()

       override func viewDidLoad() {
           super.viewDidLoad()
           UpcomingInstructorClassesCollectionView.dataSource = self
           UpcomingInstructorClassesCollectionView.delegate = self
       }

   override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
   }

    func prepare(for segue: UIStoryboardSegue, sender: UICollectionView) {
        if segue.identifier == "manageInstructorClass" {
            guard let indexPath = UpcomingInstructorClassesCollectionView.indexPathsForSelectedItems?.first else { return }
            let destinatonVC = segue.destination as? ManageInstructorClassConfirmViewController

        }
    }
   }


extension UpcomingInstructorClassesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingInstructorClasses", for: indexPath) as?
           UpcomingInstructorClassesCollectionViewCell else { return UICollectionViewCell() }
        cell.newClasses = fetchedResultsController.object(at: indexPath) as? NewClass
           cell.rescheduleButton.setDarkButtonColor(toButtonNamed: cell.rescheduleButton)
           cell.deleteButton.setDarkButtonColor(toButtonNamed: cell.deleteButton)
           cell.layer.borderColor = UIColor.black.cgColor
           cell.layer.borderWidth = 3
           cell.layer.cornerRadius = 5

           return cell
       }


   }



