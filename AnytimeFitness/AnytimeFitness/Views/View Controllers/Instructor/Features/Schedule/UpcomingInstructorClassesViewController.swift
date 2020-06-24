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

   }

   extension UpcomingInstructorClassesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           1
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingInstructorClasses", for: indexPath) as?
           UpcomingInstructorClassesCollectionViewCell else { return UICollectionViewCell() }
           cell.rescheduleButton.setDarkButtonColor(toButtonNamed: cell.rescheduleButton)
           cell.deleteButton.setDarkButtonColor(toButtonNamed: cell.deleteButton)
           cell.layer.borderColor = UIColor.black.cgColor
           cell.layer.borderWidth = 3
           cell.layer.cornerRadius = 5
           cell.imageView.setDarkBackground()

           return cell
       }

   }


