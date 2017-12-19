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
		diary.date_daily = NSDate.init()
		diary.weather = 0
		diary.diary_content = "今天的特别的早"
		
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
		fetchRequest.fetchLimit = 8 //每页大小
//		fetchRequest.fetchOffset = 1 * 20 //第几页
		
		//设置查询条件:参考exsitsObject
		//let predicate = NSPredicate(format: "id= '1' ", "")
		//fetchRequest.predicate = predicate
		
		//设置排序
		//		let stuIdSort = NSSortDescriptor(key: "stuId", ascending: false)	//按学生ID降序
		//		let nameSort = NSSortDescriptor(key: "name", ascending: true)	//按照姓名升序
		//合并多重条件
		//		let sortDescriptors:[NSSortDescriptor] = [stuIdSort,nameSort]
		//		fetchRequest.sortDescriptors = sortDescriptors
		
		do {
			let fetchedObjects = try context.fetch(fetchRequest)
			
//			for info:MXSDiary in fetchedObjects {
//				MXSLog("id=\(info.weather)")
//				MXSLog("name=\(String(describing: info.date_creat))")
//				MXSLog("sex=\(String(describing: info.date_daily))")
//				MXSLog("classId=\(String(describing: info.diary_content))")
//				MXSLog("-------------------")
//			}
			return fetchedObjects
		}
		catch {
			fatalError("不能保存：\(error)")
		}
		return []
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
