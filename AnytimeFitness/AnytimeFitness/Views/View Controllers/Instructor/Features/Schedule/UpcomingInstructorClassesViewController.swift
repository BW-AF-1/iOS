//
//  UpcomingInstructorClassesViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class UpcomingInstructorClassesViewController: UIViewController {

    @IBOutlet weak var UpcomingInstructorClassesCollectionView: UICollectionView!

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
           // destinatonVC?.updateClass = InstructorCreateClassController.sharedInstructorCreateClassController.exampleClass[indexPath.item]
           // destinatonVC?.updateClass = NewClass[indexPath.item]
        }
    }
   }


extension UpcomingInstructorClassesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return newClassArray?.count ?? 1

        InstructorCreateClassController.sharedInstructorCreateClassController.exampleClass.count
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingInstructorClasses", for: indexPath) as?
           UpcomingInstructorClassesCollectionViewCell else { return UICollectionViewCell() }
       // let upcomingClass = newClassArray?[indexPath.item]
            let upcomingClass = InstructorCreateClassController.sharedInstructorCreateClassController.exampleClass[indexPath.item]
       //  cell.newClasses = upcomingClass
           cell.rescheduleButton.setDarkButtonColor(toButtonNamed: cell.rescheduleButton)
           cell.deleteButton.setDarkButtonColor(toButtonNamed: cell.deleteButton)
           cell.layer.borderColor = UIColor.black.cgColor
           cell.layer.borderWidth = 3
           cell.layer.cornerRadius = 5

       // cell.imageView.image = UIImage(named: InstructorCreateClassController.sharedInstructorCreateClassController.exampleClass[indexPath.item].classType)
       // cell.classDateText.text = InstructorCreateClassController.sharedInstructorCreateClassController.exampleClass[indexPath.item].classDate.description
       // cell.classNameText.text = InstructorCreateClassController.sharedInstructorCreateClassController.exampleClass[indexPath.item].className
       // cell.classTimeText.text = InstructorCreateClassController.sharedInstructorCreateClassController.exampleClass[indexPath.item].classDate.description
           return cell
       }

   }


