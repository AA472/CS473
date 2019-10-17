//
//  StudentDetail.swift
//  Student Management System
//
//  Created by Aljandali, Abdullah on 10/16/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//

import UIKit

class StudentDetail: UIViewController {
    
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var campusAddress: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var photo: UIImage!


    var detailedStudent: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
