//
//  Student+CoreDataProperties.swift
//  Student Management System
//
//  Created by Aljandali, Abdullah on 10/16/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var campusAddress: String?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var homeAddress: String?
    @NSManaged public var id: Int16
    @NSManaged public var lastName: String?
    @NSManaged public var phone: Int16
    @NSManaged public var photo: NSData?

}
