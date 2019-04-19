//
//  PersonTableViewController.swift
//  RandomPairing
//
//  Created by Carson Buckley on 4/19/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        PersonController.sharedInstance.fetchPersons { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PersonController.sharedInstance.persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonTableViewCell
        let person = PersonController.sharedInstance.persons[indexPath.row]
        cell?.updateView(with: person)
        // Configure the cell...

        return cell ?? UITableViewCell()
    }

     //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let person = PersonController.sharedInstance.persons[indexPath.row]
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter Name"
        }
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let postAction = UIAlertAction(title: "Post", style: .default) { (_) in
            
            guard let bodyText = alertController.textFields?[0].text,
            !bodyText.isEmpty else { return }
            
            PersonController.sharedInstance.addPersonWith(name: bodyText, completion: { (post) in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        
        alertController.addAction(dismissAction)
        alertController.addAction(postAction)
        
        self.present(alertController, animated: true)
    }


    
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }

    @IBAction func addButtonTapped(_ sender: Any) {
        presentAlert(title: "Add a Person", message: "The person will be added to the list")
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
    }
}
