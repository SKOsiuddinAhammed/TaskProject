//
//  Person+CoreDataProperties.swift
//  InterviewTask
//
//  Created by Ahammed on 26/06/20.
//  Copyright © 2020 Ahammed. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int64

}
