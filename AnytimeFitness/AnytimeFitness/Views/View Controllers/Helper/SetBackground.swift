//
//  SetBackground.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/19/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//


import UIKit

extension UIView {
func setBackground(toImageNamed image: String = "MainFitness") {
    guard let backgroundImage = UIImage(named: image) else { return }
    let backgroundImageView = UIImageView(frame: self.bounds)
    backgroundImageView.image = backgroundImage
    backgroundImageView.contentMode = .scaleAspectFill
    backgroundImageView.alpha = CGFloat(exactly: NSNumber(value: 0.4))!
    self.insertSubview(backgroundImageView, at: 0)
}
    func setDarkBackground(toImageNamed image: String = "MainFitness") {
        guard let backgroundImage = UIImage(named: image) else { return }
        let backgroundImageView = UIImageView(frame: self.bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = CGFloat(exactly: NSNumber(value: 0.9))!
        self.insertSubview(backgroundImageView, at: 0)
    }

}
