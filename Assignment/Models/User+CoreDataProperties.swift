//
//  User+CoreDataProperties.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var mobile: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension User : Identifiable {

}
