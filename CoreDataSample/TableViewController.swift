//
//  ViewController.swift
//  CoreDataSample
//
//  Created by MTQ on 9/10/17.
//  Copyright © 2017 MTQ. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var students: [Student] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromCoreData()
    }
    
    func fetchDataFromCoreData() {
        let managedObjectContext = Database.getContext()
        
        students = try! managedObjectContext.fetch(Student.fetchRequest()) as! [Student]
        
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        if segue.identifier == "insert" {
            detailViewController.tableViewEditingStyle = .insert
        }
        else if segue.identifier == "showDetail" {
            detailViewController.tableViewEditingStyle = .edit
            guard let indexPathSelected = tableView.indexPathForSelectedRow else { return }
            detailViewController.name = students[indexPathSelected.row].name
        }
    }
}

// MARK: - UITableViewDataSource

extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure Cell
        cell.textLabel?.text = students[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let managedObjectContext = Database.getContext()
            
            let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name==%@", students[indexPath.row].name!)
            let objects = try! managedObjectContext.fetch(fetchRequest) 
            
            for object in objects {
                managedObjectContext.delete(object)
            }
            
            Database.saveContext()
            
            fetchDataFromCoreData()
        default:
            break
        }
    }
}

