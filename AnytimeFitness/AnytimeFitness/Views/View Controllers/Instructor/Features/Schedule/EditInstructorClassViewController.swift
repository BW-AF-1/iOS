//
//  EditInstructorClassViewController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/23/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import UIKit

class EditInstructorClassViewController: UIViewController {
    @IBOutlet weak var classNameText: UILabel!

    @IBOutlet weak var atendeesTableView: UITableView!
    @IBOutlet weak var editDetailButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        atendeesTableView.delegate = self
        atendeesTableView.dataSource = self
        editDetailButton.setDarkButtonColor(toButtonNamed: editDetailButton)
    }

}

extension EditInstructorClassViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassAtendees", for: indexPath)
        return cell
    }


}
