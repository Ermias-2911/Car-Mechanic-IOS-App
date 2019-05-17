//
//  User+CoreDataProperties.swift
//  
//
//  Created by Apple on 4/25/19.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var f_name: String?
    @NSManaged public var img_profile: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var address: String?

}
