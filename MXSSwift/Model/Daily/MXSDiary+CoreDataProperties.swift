//
//  MXSDiary+CoreDataProperties.swift
//  MXSSwift
//
//  Created by Alfred Yang on 21/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//
//

import Foundation
import CoreData


extension MXSDiary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MXSDiary> {
        return NSFetchRequest<MXSDiary>(entityName: "MXSDiary")
    }

    @NSManaged public var date_creat: NSDate?
    @NSManaged public var date_daily: NSDate?
    @NSManaged public var diary_content: String?
    @NSManaged public var diary_think: String?
    @NSManaged public var weather: Int32
    @NSManaged public var mood: Int32
    @NSManaged public var uuid: String?

}
