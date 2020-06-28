//
//  MainViewController.swift
//  AnytimeFitness
//
//  Created by Jarren Campos on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var firstButtonOutlet: UIButton!
    @IBOutlet var secondButtonOutlet: UIButton!
    @IBOutlet var thirdButtonOutlet: UIButton!
    @IBOutlet var fourthButtonOutlet: UIButton!
    
    var firstButton = buttonConfig(active: true)
    var secondButton = buttonConfig(active: false)
    var thirdButton = buttonConfig(active: false)
    var fourthButton = buttonConfig(active: false)

        
    var titleArray: [String] = ["The world is your gym", "Browse Classes", "Register/Cancel Classes", "Become Your Own Boss"]
    var descriptionArray: [String] = ["Welcome.", "Our expert instructors conduct classes literally anywhere. Take a yoga class on a mountaintop. Do boot camp on the beach. Go to an abandoned mansion for mat pilates. The options are limitless.", "Signing up for classes is easy. And you can cancel and reschedule classes with little to no cancellation fee.", "Instead of needing a gym to attract clients, instructors can be their own boss and set up their fitness classes with a minimal start up fee."]
    
    struct buttonConfig{
        var active: Bool
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        changeText(index: 0)
        descriptionLabel.textAlignment = .center
    }
    
    @IBAction func firstButton(_ sender: Any) {
        changeText(index: 0)
        descriptionLabel.textAlignment = .center
        firstButton.active = true
        turnOffBools(index: 0)
        setUpViews()
    }
    @IBAction func secondButton(_ sender: Any) {
        changeText(index: 1)
        secondButton.active = true
        turnOffBools(index: 1)
        setUpViews()
    }
    @IBAction func thirdButton(_ sender: Any) {
        changeText(index: 2)
        thirdButton.active = true
        turnOffBools(index: 2)
        setUpViews()
    }
    @IBAction func fourthButton(_ sender: Any) {
        changeText(index: 3)
        fourthButton.active = true
        turnOffBools(index: 3)
        setUpViews()
    }
    
    func changeText(index: Int) {
        titleLabel.text = titleArray[index]
        descriptionLabel.text = descriptionArray[index]
    }
    
    func setUpViews(){
        if firstButton.active == true{
            firstButtonOutlet.tintColor = .orange
        } else{
            firstButtonOutlet.tintColor = .white
        }
        if secondButton.active == true{
            secondButtonOutlet.tintColor = .orange
        } else{
            secondButtonOutlet.tintColor = .white
        }
        if thirdButton.active == true{
            thirdButtonOutlet.tintColor = .orange
        } else{
            thirdButtonOutlet.tintColor = .white
        }
        if fourthButton.active == true{
            fourthButtonOutlet.tintColor = .orange
        } else{
            fourthButtonOutlet.tintColor = .white
        }
    }

    func turnOffBools(index: Int){
        if index == 0{
            secondButton.active = false
            thirdButton.active = false
            fourthButton.active = false
        }
        if index == 1{
            firstButton.active = false
            thirdButton.active = false
            fourthButton.active = false
        }
        if index == 2{
            secondButton.active = false
            firstButton.active = false
            fourthButton.active = false
        }
        if index == 3{
            secondButton.active = false
            thirdButton.active = false
            firstButton.active = false
        }
    }

}
