//
//  ProfessorDetail.swift
//  Student Management System
//
//  Created by Aljandali, Abdullah on 10/16/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//

import UIKit
import CoreData

class ProfessorDetail: UIViewController {

    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var officeAddress: UITextField!
    @IBOutlet weak var homeAddress: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var photo: UIImage!
    
    
    var detailedProfessor: Professor?
    var professorIndex: Int?
    var professors: [Professor] = []
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        areButtonsEnabled(isEnabled: false)
        
        if detailedProfessor != nil{
            
            firstName.text = detailedProfessor!.value(forKeyPath: "firstName") as? String
            lastName.text = detailedProfessor!.value(forKeyPath: "lastName") as? String
            officeAddress.text = detailedProfessor!.value(forKeyPath: "officeAddress") as? String
            homeAddress.text = detailedProfessor!.value(forKeyPath: "homeAddress") as? String
            email.text = detailedProfessor!.value(forKeyPath: "email") as? String

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
        officeAddress.isUserInteractionEnabled = isEnabled
        homeAddress.isUserInteractionEnabled = isEnabled
        email.isUserInteractionEnabled = isEnabled

    }
    
    func save() {
        
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
        
        
        professors[professorIndex!].setValue(firstName.text, forKeyPath: "firstName")
        professors[professorIndex!].setValue(lastName.text, forKeyPath: "lastName")
        professors[professorIndex!].setValue(officeAddress.text, forKeyPath: "officeAddress")
        professors[professorIndex!].setValue(homeAddress.text, forKeyPath: "homeAddress")
        professors[professorIndex!].setValue(email.text, forKeyPath: "email")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
