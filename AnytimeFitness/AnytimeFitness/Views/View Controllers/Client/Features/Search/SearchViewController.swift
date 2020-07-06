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
        fitnessCollection.allowsMultipleSelection = true
        view.setLightButtonColor(toButtonNamed: nextButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fitnessCollection.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextVC = segue.destination as? LocationSearchViewController else { return }
        if selectedFitnessTypes.count > 1 {
            nextVC.selectedFitness = selectedFitnessTypes
        } else {
            nextVC.selectedFitness = ClassTypeInt.allFitnessTypeNames
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ClassTypeInt.allFitnessTypeKeys.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fitnessType", for: indexPath) as? FitnessTypeCollectionViewCell else { return UICollectionViewCell() }
        cell.layer.borderWidth = 4.0
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.fitnessImageView.image = UIImage(named: ClassTypeInt.allFitnessTypeNames[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 4.0
        cell?.layer.borderColor = UIColor.systemOrange.cgColor
        selectedFitnessTypes.append(ClassTypeInt.allFitnessTypeNames[indexPath.item])
        print("New added array: \(selectedFitnessTypes)")
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 4.0
        cell?.layer.borderColor = UIColor.gray.cgColor
        print("New added array: \(selectedFitnessTypes)")
        selectedFitnessTypes.removeAll{ $0 == ClassTypeInt.allFitnessTypeNames[indexPath.item]}
        print("New added array: \(selectedFitnessTypes)")
    }

}
