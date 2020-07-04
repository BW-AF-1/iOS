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
        let imageView = UIImage(named: ClassTypeInt.allFitnessTypeNames[indexPath.item])
        let blackCover: UIView = UIView(frame: cell.contentView.frame)
        blackCover.backgroundColor = UIColor.black
        blackCover.layer.opacity = 0.3
        cell.backgroundView = UIImageView(image: imageView)
        cell.backgroundView?.addSubview(blackCover)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fitnessType", for: indexPath) as? FitnessTypeCollectionViewCell else { return }
        cell.fitnessImageView.setDarkBackground(toImageNamed: ClassTypeInt.allFitnessTypeNames[indexPath.item])
        if selectedFitnessTypes.contains(ClassTypeInt.allFitnessTypeNames[indexPath.item]) { selectedFitnessTypes.removeAll{ $0 == ClassTypeInt.allFitnessTypeNames[indexPath.item]}
        } else {
            selectedFitnessTypes.append(ClassTypeInt.allFitnessTypeNames[indexPath.item])
        }
        
        print("New added array: \(selectedFitnessTypes)")
    }

}
