//
//  CourseDetail.swift
//  Student Management System
//
//  Created by Aljandali, Abdullah on 10/16/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//

import UIKit
import CoreData

class CourseDetail: UIViewController {

    
    @IBOutlet weak var deptCode: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var fromTime: UITextField!
    @IBOutlet weak var toTime: UITextField!
    @IBOutlet weak var daysItMeets: UITextField!

    
    
    var detailedCourse: NewCourse?
    var courseIndex: Int?
    var courses: [NewCourse] = []

    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        areButtonsEnabled(isEnabled: false)

        if detailedCourse != nil{
        
        deptCode.text = detailedCourse!.value(forKeyPath: "deptCode") as? String
        name.text = detailedCourse!.value(forKeyPath: "name") as? String
        number.text = detailedCourse!.value(forKeyPath: "number") as? String
        fromTime.text = detailedCourse!.value(forKeyPath: "fromTime") as? String
        toTime.text = detailedCourse!.value(forKeyPath: "toTime") as? String
        daysItMeets.text = detailedCourse!.value(forKeyPath: "daysItMeets") as? String
        }
    }
    
    
    @IBAction func editButtonClicked(_ sender: UIBarButtonItem) {
        
        if editButton.title == "Edit"{
            areButtonsEnabled(isEnabled: true)
            editButton.title = "Done"
        }
        else{
            areButtonsEnabled(isEnabled: false)
            editButton.title = "Edit"
            save()
        }
    }
    

    
    func areButtonsEnabled (isEnabled : Bool){
        deptCode.isUserInteractionEnabled = isEnabled
        name.isUserInteractionEnabled = isEnabled
        number.isUserInteractionEnabled = isEnabled
        fromTime.isUserInteractionEnabled = isEnabled
        toTime.isUserInteractionEnabled = isEnabled
        daysItMeets.isUserInteractionEnabled = isEnabled
    }
    
    func save() {
       
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
        
        
        courses[courseIndex!].setValue(deptCode.text, forKeyPath: "deptCode")
        courses[courseIndex!].setValue(number.text, forKeyPath: "number")
        courses[courseIndex!].setValue(name.text, forKeyPath: "name")
        courses[courseIndex!].setValue(fromTime.text, forKeyPath: "fromTime")
        courses[courseIndex!].setValue(toTime.text, forKeyPath: "toTime")
        courses[courseIndex!].setValue(daysItMeets.text, forKeyPath: "daysItMeets")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
