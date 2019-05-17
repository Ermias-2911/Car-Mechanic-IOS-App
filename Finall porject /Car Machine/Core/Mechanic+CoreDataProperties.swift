//
//  Mechanic+CoreDataProperties.swift
//  
//
//  Created by Apple on 4/25/19.
//
//

import Foundation
import CoreData


extension Mechanic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mechanic> {
        return NSFetchRequest<Mechanic>(entityName: "Mechanic")
    }

    @NSManaged public var address: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var profile_img: NSData?
    @NSManaged public var type_user: String?

}
