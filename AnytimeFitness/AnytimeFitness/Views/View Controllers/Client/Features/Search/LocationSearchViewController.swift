//
//  LocationSearchViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/19/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class LocationSearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var locationSearch: UISearchBar!

    @IBOutlet weak var nextButton: UIButton!

    @IBOutlet weak var locationTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationSearch.delegate = self
        view.setLightButtonColor(toButtonNamed: nextButton)
    }

    func searchLocationClicked(_ locationSearch: UISearchBar) {
        guard let locationSearch = locationSearch.text, locationSearch != "" else { return }
        

    }

}

extension LocationSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        InstructorCreateClassController.sharedInstructorCreateClassController.exampleClass.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        cell.textLabel?.text = InstructorCreateClassController.sharedInstructorCreateClassController.exampleClass[indexPath.row].classLocation
        return cell
    }


}
