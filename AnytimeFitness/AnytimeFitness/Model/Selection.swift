//
//  Selection.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

struct Selection {
    var selectionName: String
    var selectionImage: UIImage?
    
    init(selectionName: String, selectionImage: String) {
        self.selectionName = selectionName
        self.selectionImage = UIImage(named: selectionImage)
    }
}

