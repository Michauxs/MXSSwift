//
//  MXSMenu+CoreDataProperties.swift
//  MXSSwift
//
//  Created by Alfred Yang on 29/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//
//

import Foundation
import CoreData


extension MXSMenu {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MXSMenu> {
        return NSFetchRequest<MXSMenu>(entityName: "MXSMenu")
    }

    @NSManaged public var name: String?

}
