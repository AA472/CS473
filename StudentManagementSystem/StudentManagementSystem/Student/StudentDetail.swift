//
//  StudentDetail.swift
//  Student Management System
//
//  Created by Aljandali, Abdullah on 10/16/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//

import UIKit
import CoreData

class StudentDetail: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var campusAddress: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var photo: UIImage!
    @IBOutlet weak var editButton: UIBarButtonItem!


    var detailedStudent: Student?
    var studentIndex: Int?
    var students: [Student] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        areButtonsEnabled(isEnabled: false)
        
        if detailedStudent != nil{
            
            firstName.text = detailedStudent!.value(forKeyPath: "firstName") as? String
            lastName.text = detailedStudent!.value(forKeyPath: "lastName") as? String
            id.text = detailedStudent!.value(forKeyPath: "id") as? String
            campusAddress.text = detailedStudent!.value(forKeyPath: "campusAddress") as? String
            phone.text = detailedStudent!.value(forKeyPath: "phone") as? String
            email.text = detailedStudent!.value(forKeyPath: "email") as? String
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
        firstName.isUserInteractionEnabled = isEnabled
        lastName.isUserInteractionEnabled = isEnabled
        id.isUserInteractionEnabled = isEnabled
        campusAddress.isUserInteractionEnabled = isEnabled
        phone.isUserInteractionEnabled = isEnabled
        email.isUserInteractionEnabled = isEnabled
    }
    
    func save() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        
        do {
            students = try managedContext.fetch(fetchRequest) as! [Student]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        students[studentIndex!].setValue(firstName.text, forKeyPath: "firstName")
        students[studentIndex!].setValue(lastName.text, forKeyPath: "lastName")
        students[studentIndex!].setValue(id.text, forKeyPath: "id")
        students[studentIndex!].setValue(campusAddress.text, forKeyPath: "campusAddress")
        students[studentIndex!].setValue(phone.text, forKeyPath: "phone")
        students[studentIndex!].setValue(email.text, forKeyPath: "email")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
