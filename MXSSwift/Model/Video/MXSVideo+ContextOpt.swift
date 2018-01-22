//
//  MXSVideo+ContextOpt.swift
//  MXSSwift
//
//  Created by Alfred Yang on 22/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import Foundation
import CoreData

extension MXSVideo {
	
	static let MXSEntityName = "MXSVideo"
	
	static public func addVideoData(_ info : Dictionary<String,Any>) {
		
		let context = MXSVideoDataCmd.shared.managedObjectContext
		let v = NSEntityDescription.insertNewObject(forEntityName: MXSEntityName, into:context ) as! MXSVideo
		v.name = info["name"] as? String
		v.lastSecond = info["last_second"] as! Double
		v.isSecret = false
		
		do {
			try context.save()
			MXSLog("保存成功")
		} catch {
			fatalError("不能保存：\(error)")
		}
	}
	
	static public func fetchVideoData(_ name: String ) -> MXSVideo {
		
		let context = MXSVideoDataCmd.shared.managedObjectContext
		let fetchRequest : NSFetchRequest<MXSVideo> = (MXSVideo.fetchRequest())
		
		//设置查询条件:参考exsitsObject
		let predicate = NSPredicate(format: "name CONTAINS %@", name)
		fetchRequest.predicate = predicate
		
		do {
			let fetchedObjects = try context.fetch(fetchRequest)
			return fetchedObjects.first!
		}
		catch {
			fatalError("不能匹配：\(error)")
		}
		
	}
	
	static public func removeVideoData(_ name: String) {
		let context = MXSVideoDataCmd.shared.managedObjectContext
		let fetchRequest : NSFetchRequest<MXSVideo> = (MXSVideo.fetchRequest())
		
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
