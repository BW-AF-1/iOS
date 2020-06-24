//
//  UpcomingClassViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class UpcomingClassViewController: UIViewController {
    @IBOutlet weak var upcomingClassesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingClassesCollectionView.dataSource = self
        upcomingClassesCollectionView.delegate = self
    }

}

extension UpcomingClassViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingClasses", for: indexPath) as?
        UpcomingClassesCollectionViewCell else { return UICollectionViewCell() }
        cell.rescheduleButton.setDarkButtonColor(toButtonNamed: cell.rescheduleButton)
        cell.deleteButton.setDarkButtonColor(toButtonNamed: cell.deleteButton)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 5
        cell.imageView.setDarkBackground()

        return cell
    }

}
