//
//  Message+CoreDataProperties.swift
//  
//
//  Created by Frederick Lee on 23/06/2017.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var contact: Contact?

}
