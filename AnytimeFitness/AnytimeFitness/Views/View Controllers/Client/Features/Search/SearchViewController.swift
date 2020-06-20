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
            activeNextButton()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fitnessCollection.delegate = self
        fitnessCollection.dataSource = self
        nextButton.layer.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1).cgColor
        nextButton.layer.cornerRadius = 5
    }

    private func activeNextButton() {
        nextButton.layer.backgroundColor = UIColor(red: 1, green: 0.573, blue: 0.2, alpha: 1).cgColor
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fitnessTypes.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fitnessType", for: indexPath)
        if cell.isSelected {
            cell.contentView.setDarkBackground(toImageNamed: fitnessTypes[indexPath.item])
        } else {
            cell.contentView.setBackground(toImageNamed: fitnessTypes[indexPath.item])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "fitnessType", for: indexPath)
        if selectedFitnessTypes.contains(fitnessTypes[indexPath.item]) { selectedFitnessTypes.removeAll{ $0 == fitnessTypes[indexPath.item]} } else if selectedCell.isSelected {
            selectedFitnessTypes.append(fitnessTypes[indexPath.item])
        }
        print("New added array: \(selectedFitnessTypes)")
    }

}



