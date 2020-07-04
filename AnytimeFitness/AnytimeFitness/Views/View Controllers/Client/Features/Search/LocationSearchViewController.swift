//
//  LocationSearchViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/19/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit
import CoreData

class LocationSearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var locationTableView: UITableView!

    var selectedFitness: [String] = [] {
        didSet {
            print("selected Fitness Array: \(selectedFitness)")
        }
    }

    var fetchRequestResult: [NewClass]? = {
        let fetchRequest: NSFetchRequest<NewClass> = NewClass.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        var results: [NewClass] = []
        do {
            results = try moc.fetch(fetchRequest)
        } catch {
            NSLog("error fetching NewClass objects")
        }
        return results
    }()

    var classLocations: [String] = [] {
        didSet {
            print("class locations: \(classLocations)")
        }
    }

    var searchedClassLocations: [String] = []

    var typeLocationClass: [NewClass] = [] {
        didSet {
            print("class table view selected: \(typeLocationClass)")
        }
    }

    var tableViewSelected: [NewClass] = [] {
        didSet {
            print("class table view selected: \(tableViewSelected)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        locationTableView.delegate = self
        locationTableView.dataSource = self
        view.setLightButtonColor(toButtonNamed: nextButton)
        if let existingClasses = fetchRequestResult {
            for element in existingClasses.enumerated() {
                if selectedFitness.contains(element.element.classTypeCD) {
                    classLocations.append(element.element.classLocationCD)
                    typeLocationClass.append(element.element)
                }
            }
        }
    }


    func searchForLocation(with searchTerm: String) {
        for element in classLocations {
            if element.containsIgnoringCase(find: searchTerm) {
                if searchedClassLocations.contains(element) { return } else {
                    searchedClassLocations.append(element)
                }
            } else {
                searchedClassLocations.removeAll { $0 == element}
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text {
            searchForLocation(with: search)
            self.locationTableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let nextVC = segue.destination as? ClassDetailSearchViewController else { return }
        if tableViewSelected.isEmpty {
            nextVC.selectedLocations = typeLocationClass
        } else {
           nextVC.selectedLocations = tableViewSelected
        }
    }
}


extension LocationSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedClassLocations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        cell.textLabel?.text = searchedClassLocations[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = searchedClassLocations[indexPath.row]
        for element in typeLocationClass {
            if element.classLocationCD == selected {
                tableViewSelected.append(element)
            }
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deSelected = searchedClassLocations[indexPath.row]
        for element in typeLocationClass {
            if element.classLocationCD.contains(find: deSelected) {
                tableViewSelected.removeAll { $0.classLocationCD == deSelected}
            }
        }
    }
}

