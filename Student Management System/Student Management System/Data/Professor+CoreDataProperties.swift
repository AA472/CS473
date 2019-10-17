//
//  Professor+CoreDataProperties.swift
//  Student Management System
//
//  Created by Aljandali, Abdullah on 10/16/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//
//

import Foundation
import CoreData


extension Professor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Professor> {
        return NSFetchRequest<Professor>(entityName: "Professor")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var homeAddress: String?
    @NSManaged public var lastName: String?
    @NSManaged public var officeAddress: String?
    @NSManaged public var photo: NSData?

}
