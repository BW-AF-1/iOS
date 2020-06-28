//
//  SignUpSelectionViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class SignUpSelectionViewController: UIViewController {
    
    var selectionController = SelectionController()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
    }
}

extension SignUpSelectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectionController.selections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCell", for: indexPath) as? CellSignUpCollectionViewCell else { return UICollectionViewCell()}
        
        let selectionCard = selectionController.selections[indexPath.item]
        cell.selection = selectionCard
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "instructorSignUp", sender: self)
        } else if indexPath.row == 1 {
            self.performSegue(withIdentifier: "clientSignUp", sender: self)
        }
    }
}
