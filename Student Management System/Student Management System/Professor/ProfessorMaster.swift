//
//  ProfessorMaster.swift
//  Student Management System
//
//  Created by Aljandali, Abdullah on 10/16/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//

import UIKit
import CoreData

class ProfessorMaster: UITableViewController {

    var professors: [Professor] = []
    var professorDetail: ProfessorDetail? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            professorDetail = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ProfessorDetail
        }
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Professor")
        
        do {
            professors = try managedContext.fetch(fetchRequest) as! [Professor]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Professor", message: "Add a new professor", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?[0],
                let firstName = textField.text else {
                    return
            }
            guard let textField2 = alert.textFields?[1],
                let lastName = textField2.text else {
                    return
            }
            let officeAddress = alert.textFields?[2].text
            let homeAddress = alert.textFields?[3].text
            let email = alert.textFields?[4].text

            self.save(firstName: firstName, lastName: lastName, officeAddress: officeAddress! , homeAddress: homeAddress!,email: email! )
            print(self.professors.count + 1)
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField { (textField) in
            textField.placeholder = "First Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Last Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Office Address"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Home Address"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    func save(firstName: String, lastName: String, officeAddress: String, homeAddress: String, email: String ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Professor", in: managedContext)!
        let professor = NSManagedObject(entity: entity, insertInto: managedContext)
        professor.setValue(firstName, forKeyPath: "firstName")
        professor.setValue(lastName, forKeyPath: "lastName")
        professor.setValue(officeAddress, forKeyPath: "officeAddress")
        professor.setValue(homeAddress, forKeyPath: "homeAddress")
        professor.setValue(email, forKeyPath: "email")

        do {
            try managedContext.save()
            professors.append(professor as! Professor)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return professors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let professor = professors[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = professor.value(forKeyPath: "firstName") as? String
        return cell
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
 
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = professors[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! ProfessorDetail
                controller.detailedProfessor = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

}
