//
//  Item+CoreDataProperties.swift
//  
//
//  Created by Jefin on 01/11/22.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var itemTitle: String?
    @NSManaged public var itemImageUrl: String?
    @NSManaged public var itemId: Int32
    @NSManaged public var itemDescription: String?

}
