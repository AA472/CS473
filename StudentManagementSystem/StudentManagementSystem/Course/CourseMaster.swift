//
//  CourseMaster.swift
//  Student Management System
//
//  Created by Aljandali, Abdullah on 10/16/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//

import UIKit
import CoreData

class CourseMaster: UITableViewController {
    
    var courses: [NewCourse] = []
    var courseDetail: CourseDetail? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            courseDetail = (controllers[controllers.count-1] as! UINavigationController).topViewController as? CourseDetail
        }
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewCourse")
        
        do {
            courses = try managedContext.fetch(fetchRequest) as! [NewCourse]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Name", message: "Add a new course", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let DeptCode = textField.text else {
                    return
            }
            
            let number = alert.textFields?[1].text
            let title = alert.textFields?[2].text
            let starts = alert.textFields?[3].text
            let ends = alert.textFields?[4].text
            let days = alert.textFields?[5].text

            
            self.save(deptCode: DeptCode, number: number!, title: title!, starts: starts!, ends: ends!, days: days!)
            print(self.courses.count + 1)
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField { (textField) in
            textField.placeholder = "Department Code:"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Course Number:"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Course Title:"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Starts at:"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Ends at:"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Day it meets:"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    func save(deptCode: String, number: String, title: String, starts: String, ends: String, days: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "NewCourse", in: managedContext)!
        let course = NSManagedObject(entity: entity, insertInto: managedContext)
        course.setValue(deptCode, forKeyPath: "deptCode")
        course.setValue(number, forKeyPath: "number")
        course.setValue(title, forKeyPath: "name")
        course.setValue(starts, forKeyPath: "fromTime")
        course.setValue(ends, forKeyPath: "toTime")
        course.setValue(days, forKeyPath: "daysItMeets")

        
        do {
            try managedContext.save()
            courses.append(course as! NewCourse)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let course = courses[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = course.value(forKeyPath: "name") as? String
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
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            do {
                managedContext.delete(courses[indexPath.row])
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewCourse")
            
            do {
                courses = try managedContext.fetch(fetchRequest) as! [NewCourse]
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
            tableView.reloadData()
            
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

    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = courses[indexPath.row]
                let courseIndex = indexPath.row
                let controller = (segue.destination as! UINavigationController).topViewController as! CourseDetail
                controller.detailedCourse = object
                controller.courseIndex = courseIndex
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}
