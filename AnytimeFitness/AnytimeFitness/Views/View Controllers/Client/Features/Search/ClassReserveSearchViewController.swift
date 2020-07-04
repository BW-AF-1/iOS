//
//  ClassReserveSearchViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/22/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class ClassReserveSearchViewController: UIViewController {
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var classNameText: UILabel!
    @IBOutlet weak var classDateText: UILabel!
    @IBOutlet weak var classTimeText: UILabel!
    @IBOutlet weak var classLocationText: UILabel!
    @IBOutlet weak var reservedRatio: UILabel!
    @IBOutlet weak var remainingNumber: UILabel!
    @IBOutlet weak var reserveButton: UIButton!

    var classManagementController = ClassManagementController()

    var finalClass: NewClass? {
        didSet {
            print("this is the final class: \(String(describing: finalClass))")
        }
    }
    let currentClient = NetworkController.sharedNetworkController.currentCDClient
    var currentClientClasses: [NewClass] = [] {
            didSet {
                print("list of currentClientClasses: \(currentClientClasses)")
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        reserveButton.setDarkButtonColor(toButtonNamed: reserveButton)
        guard let finalClass = finalClass else { return }
        classImageView.image = UIImage(named: finalClass.classTypeCD)
        classNameText.text = finalClass.classNameCD
        classDateText.text = classManagementController.formatClassDate(with: finalClass)
        classTimeText.text = classManagementController.formatClassTime(with: finalClass)
        classLocationText.text = finalClass.classLocationCD
        reservedRatio.text = "\(finalClass.classCurrentSizeCD)/ \(finalClass.classMaxSizeCD)"
        remainingNumber.text = "\(finalClass.classMaxSizeCD - finalClass.classCurrentSizeCD) spot(s)"

        guard let currentClient = currentClient else { return }
                      if let classArray = currentClient.registeredClasses!.allObjects as? [NewClass], !classArray.isEmpty {
                          for element in classArray {
                             if currentClientClasses.contains(element) { return } else {
                              currentClientClasses.append(element)
                             }
                              viewDidLoad()
                          }
                      }
        if currentClientClasses.contains(finalClass) {
            reserveButton.setLightButtonColor(toButtonNamed: reserveButton)
            reserveButton.isEnabled = false
            let alert = UIAlertController(
                              title: "Alert",
                              message: "You have already signed up for this class.",
                              preferredStyle: .alert
                          )
                          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                          present(alert, animated: true, completion: nil)
        }

        if finalClass.classMaxSizeCD == finalClass.classCurrentSizeCD {
            reserveButton.setLightButtonColor(toButtonNamed: reserveButton)
            reserveButton.isEnabled = false
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              guard let nextVC = segue.destination as? ConfirmClassSearchViewController else { return }
          nextVC.confirmClass = finalClass
          }

}
