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
    backgroundImageView.alpha = CGFloat(exactly: NSNumber(value: 0.5))!
    self.insertSubview(backgroundImageView, at: 0)
}
    func setDarkBackground(toImageNamed image: String = "MainFitness") {
        guard let backgroundImage = UIImage(named: image) else { return }
        let backgroundImageView = UIImageView(frame: self.bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.alpha = CGFloat(exactly: NSNumber(value: 0.8))!
        let blackCover: UIView = UIView(frame: frame)
        blackCover.backgroundColor = UIColor.black
        blackCover.layer.opacity = 0.75
        backgroundImageView.addSubview(blackCover)
        self.insertSubview(backgroundImageView, at: 0)
    }

    func setDarkButtonColor(toButtonNamed button: UIButton){
           button.layer.backgroundColor = UIColor(red: 1, green: 0.573, blue: 0.2, alpha: 1).cgColor
           button.layer.cornerRadius = 5
       }

       func setLightButtonColor(toButtonNamed button: UIButton){
           button.layer.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1).cgColor
           button.layer.cornerRadius = 5
       }

}
