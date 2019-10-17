//
//  Course+CoreDataProperties.swift
//  Student Management System
//
//  Created by Aljandali, Abdullah on 10/16/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var daysItMeets: String?
    @NSManaged public var deptCode: String?
    @NSManaged public var name: String?
    @NSManaged public var number: Int16
    @NSManaged public var fromTime: String?
    @NSManaged public var toTime: String?

}
