//
//  DetailViewController.swift
//  CoreDataSample
//
//  Created by MTQ on 9/10/17.
//  Copyright © 2017 MTQ. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
   
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        let managedObjectContext = Database.getContext()
        
        let student = Student(context: managedObjectContext)
        student.name = nameTextField.text
        
        Database.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
}
