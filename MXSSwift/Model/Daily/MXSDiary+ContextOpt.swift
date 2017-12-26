//
//  MXSDiary+ContextOpt.swift
//  MXSSwift
//
//  Created by Alfred Yang on 16/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension MXSDiary {
	
	static let MXSDiaryEntityName = "MXSDiary"
	
	static public func addDiaryWithDictionary(_ value: Dictionary<String, Any>) {
//		let entity = NSEntityDescription.entity(forEntityName: "MXSDiary", in: doc.managedObjectContext)
//		let diary = NSManagedObject(entity: entity!, insertInto: doc.managedObjectContext) as! MXSDiary
		
		let context = MXSDiaryModelCmd.shared.managedObjectContext
		let diary = NSEntityDescription.insertNewObject(forEntityName: MXSDiaryEntityName, into:context ) as! MXSDiary
		
		diary.date_creat = NSDate.init()
		diary.date_daily = value["date_daily"] as? NSDate
		diary.weather = Int32(value["weather"] as! Int)
		diary.mood = 5
		diary.diary_content = value["diary_content"] as? String
		diary.diary_think = value["diary_think"] as? String
		diary.uuid = String.MD5String()
		
		do {
			try context.save()
			MXSLog("保存成功")
		} catch {
			fatalError("不能保存：\(error)")
		}
		
	}
	
	static public func fetchDiaryObjects() -> Array<MXSDiary> {
		
		let context = MXSDiaryModelCmd.shared.managedObjectContext
		let fetchRequest : NSFetchRequest<MXSDiary> = (MXSDiary.fetchRequest())
//		fetchRequest.fetchLimit = 8 //每页大小
//		fetchRequest.fetchOffset = 1 * 20 //第几页
		
		//设置查询条件:参考exsitsObject
		//let predicate = NSPredicate(format: "id= '1' ", "")
		//fetchRequest.predicate = predicate
		
		//设置排序
		let desc = NSSortDescriptor(key: "date_daily", ascending: false)	//按学生ID降序
		//		let nameSort = NSSortDescriptor(key: "name", ascending: true)	//按照姓名升序
		//合并多重条件
		//		fetchRequest.sortDescriptors = [stuIdSort,nameSort]
		fetchRequest.sortDescriptors = [desc]
		
		do {
			let fetchedObjects = try context.fetch(fetchRequest)
			return fetchedObjects
		}
		catch {
			fatalError("不能保存：\(error)")
		}
		return []
	}
	
	
	static public func removeDiaryObjects(_ array:Array<MXSDiary>) {
		
		let context = MXSDiaryModelCmd.shared.managedObjectContext
		
		for diary in array {
			context.delete(diary)
		}
		do {
			try context.save()
			MXSLog("删除成功")
		} catch {
			fatalError("不能删除：\(error)")
		}
//		let fetchRequest : NSFetchRequest<MXSDiary> = (MXSDiary.fetchRequest())
//
//		//设置查询条件:参考exsitsObject
//		let predicate = NSPredicate(format: "uuid= %@ ", diary.uuid!)
//		fetchRequest.predicate = predicate
		
	}
	
	
	static public func fetchDiaryObjects2(completeBlock:@escaping (_ fetch:[MXSDiary]) -> Void) {
		MXSLog("fetch")
		let context = MXSDiaryModelCmd.shared.managedObjectContext
		let fetchRequest : NSFetchRequest<MXSDiary> = (MXSDiary.fetchRequest())
		do {
			let fetchedObjects = try context.fetch(fetchRequest)
			completeBlock(fetchedObjects)
		}
		catch {
			completeBlock([])
			fatalError("不能保存：\(error)")
		}
	}
}
