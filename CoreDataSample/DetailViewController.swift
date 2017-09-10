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
        let managedObjectContext = Database.getContext()
        switch tableViewEditingStyle {
        case .insert:
            let student = Student(context: managedObjectContext)
            student.name = nameTextField.text
        case .edit:
            let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name==%@", name!)
            let objects = try! managedObjectContext.fetch(fetchRequest)
            
            for object in objects {
                object.name = nameTextField.text
            }
        }
        Database.saveContext()

        navigationController?.popViewController(animated: true)
    }
}
