//
//  MXSMenu+ContrxtOpt.swift
//  MXSSwift
//
//  Created by Alfred Yang on 29/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation
import CoreData

extension MXSMenu {
	
	static let MXSEntityName = "MXSMenu"
	
	static public func addDish(_ menu : Array<String>) {
		
		let context = MXSMenuDataCmd.shared.managedObjectContext
		for name in menu {
			
			let dish = NSEntityDescription.insertNewObject(forEntityName: MXSEntityName, into:context ) as! MXSMenu
			dish.name = name
		}
		
		do {
			try context.save()
			MXSLog("保存成功")
		} catch {
			fatalError("不能保存：\(error)")
		}
		
	}
	
	static public func fetchDish(_ name: String = "all") -> Array<MXSMenu> {
		
		let context = MXSMenuDataCmd.shared.managedObjectContext
		let fetchRequest : NSFetchRequest<MXSMenu> = (MXSMenu.fetchRequest())
		
		//设置查询条件:参考exsitsObject
		if name != "all" {
			let predicate = NSPredicate(format: "name CONTAINS %@", name)
			fetchRequest.predicate = predicate
		}
		
		do {
			let fetchedObjects = try context.fetch(fetchRequest)
			return fetchedObjects
		}
		catch {
			fatalError("不能匹配：\(error)")
		}
		return []
	}
	
	static public func removeDish(_ name: String) {
		let context = MXSMenuDataCmd.shared.managedObjectContext
		let fetchRequest : NSFetchRequest<MXSMenu> = (MXSMenu.fetchRequest())
		
		//设置查询条件:参考exsitsObject
		let predicate = NSPredicate(format: "name= %@", name)
		fetchRequest.predicate = predicate
		
		
		do {
			let fetchedObjects = try context.fetch(fetchRequest)
			for dish in fetchedObjects {
				context.delete(dish)
			}
		}
		catch {
			fatalError("不能匹配：\(error)")
		}
		
		do {
			try context.save()
			MXSLog("删除成功")
		} catch {
			fatalError("不能删除：\(error)")
		}
	}
	
}
