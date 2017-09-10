//
//  DetailViewController.swift
//  CoreDataSample
//
//  Created by MTQ on 9/10/17.
//  Copyright © 2017 MTQ. All rights reserved.
//

import UIKit
import CoreData

enum TableViewEditingStyle {
    case insert
    case edit
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var name: String?
    var tableViewEditingStyle: TableViewEditingStyle = .insert
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let name = name else { return }
        nameTextField.text = name
    }
   
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        switch tableViewEditingStyle {
        case .insert:
            Database.insertObjectToCoreData(name: nameTextField.text!)
            navigationController?.popViewController(animated: true)
        case .edit:
            performSegue(withIdentifier: "unwindFromDetailViewControllerToTableViewController", sender: self)
        }
    }
}
