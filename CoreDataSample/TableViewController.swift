//
//  ViewController.swift
//  CoreDataSample
//
//  Created by MTQ on 9/10/17.
//  Copyright © 2017 MTQ. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var students: [Student] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromCoreData()
    }
    
    func fetchDataFromCoreData() {
        let managedObjectContext = Database.getContext()
        
        students = try! managedObjectContext.fetch(Student.fetchRequest()) as! [Student]
        
        tableView.reloadData()
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
}

