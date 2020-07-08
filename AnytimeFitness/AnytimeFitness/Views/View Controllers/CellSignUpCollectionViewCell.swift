//
//  CellSignUpCollectionViewCell.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class CellSignUpCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var selectionBackground: UIImageView!
    @IBOutlet var selectiontitle: UILabel!

    var selection: Selection? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let selectionLabel = selection?.selectionName,
            let selectionImage = selection?.selectionImage else { return }
        selectionBackground.image = selectionImage
        selectiontitle.text = selectionLabel
    }
    
}
