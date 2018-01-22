//
//  MXSVideo+CoreDataProperties.swift
//  MXSSwift
//
//  Created by Alfred Yang on 22/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//
//

import Foundation
import CoreData


extension MXSVideo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MXSVideo> {
        return NSFetchRequest<MXSVideo>(entityName: "MXSVideo")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastSecond: Double
    @NSManaged public var isSecret: Bool
    @NSManaged public var duration: Double

}
