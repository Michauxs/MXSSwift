//
//  MXSDiary+CoreDataProperties.swift
//  MXSSwift
//
//  Created by Alfred Yang on 16/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//
//

import Foundation
import CoreData


extension MXSDiary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MXSDiary> {
        return NSFetchRequest<MXSDiary>(entityName: "MXSDiary")
    }

    @NSManaged public var date_daily: NSDate?
    @NSManaged public var date_creat: NSDate?
    @NSManaged public var weather: Int32
    @NSManaged public var diary_context: String?

}

extension MXSDiary {
	
	@objc(addDiaryObjext:)
	@NSManaged public func addDiaryObject(_ value:MXSDiary)
}
