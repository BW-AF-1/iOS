//
//  SearchViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/18/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var fitnessCollection: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!

    var fitnessTypes: [String] = ["Boxing", "Dancing", "Biking", "Pilates", "Running", "Stretch", "Weightlifting", "Yoga", "Bootcamp", "Cardio", "Functional Fitness", "Ect."]

    var selectedFitnessTypes: [String] = [] {
        didSet{
            if selectedFitnessTypes.isEmpty {
                view.setLightButtonColor(toButtonNamed: nextButton)
            } else {
                view.setDarkButtonColor(toButtonNamed: nextButton)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fitnessCollection.delegate = self
        fitnessCollection.dataSource = self
        view.setLightButtonColor(toButtonNamed: nextButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fitnessCollection.reloadData()
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fitnessTypes.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fitnessType", for: indexPath) as? FitnessTypeCollectionViewCell else { return UICollectionViewCell() }
        cell.fitnessImageView.image = UIImage(named: fitnessTypes[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if selectedFitnessTypes.contains(fitnessTypes[indexPath.item]) { selectedFitnessTypes.removeAll{ $0 == fitnessTypes[indexPath.item]}
        } else {
            selectedFitnessTypes.append(fitnessTypes[indexPath.item])
        }
        
        print("New added array: \(selectedFitnessTypes)")
    }

}
