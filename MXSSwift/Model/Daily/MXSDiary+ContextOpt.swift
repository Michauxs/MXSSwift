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
	
	static public func addDiaryWithDictionary(_ value: Dictionary<String, Any>) {
		
//		let doc = MXSDocumentCmd.shared.getDocument() as UIManagedDocument
		
//		let diary = NSEntityDescription.insertNewObject(forEntityName: "MXSDiary", into:doc.managedObjectContext ) as! MXSDiary
//		let entity = NSEntityDescription.entity(forEntityName: "MXSDiary", in: doc.managedObjectContext)
//		let diary = NSManagedObject(entity: entity!, insertInto: doc.managedObjectContext) as! MXSDiary
		
		let doc = MXSDiaryModelCmd().managedObjectContext
		let diary = NSEntityDescription.insertNewObject(forEntityName: "MXSDiary", into:doc ) as! MXSDiary
		
		diary.date_creat = NSDate.init()
		diary.date_daily = NSDate.init()
		diary.weather = 0
		diary.diary_content = "今天的特别的早"
		
		//保存
		do {
			try doc.save()
		} catch {
			fatalError("不能保存：\(error)")
		}
		
	}
	
	static public func demoWithDictionary(_ value: Dictionary<String, Any>) {
		
//		_ = MXSDocumentCmd.shared.managedContext
		
//		let manager = FileManager.default()
//		let urlForDocument = manager.URLsForDirectory( NSSearchPathDirectory.DocumentDirectory, inDomains:NSSearchPathDomainMask.UserDomainMask)
//		let url = urlForDocument[0] as NSURL
//		createFile("test.txt", fileBaseUrl: url)
		
	}
//	func createFile(name:String,fileBaseUrl:NSURL){
//		let manager = NSFileManager.defaultManager()
//
//		let file = fileBaseUrl.URLByAppendingPathComponent(name)
//		print("文件: \(file)")
//		let exist = manager.fileExistsAtPath(file.path!)
//		if !exist {
//			let data = NSData(base64EncodedString:"aGVsbG8gd29ybGQ=",options:.IgnoreUnknownCharacters)
//			let createSuccess = manager.createFileAtPath(file.path!,contents:data,attributes:nil)
//			print("文件创建结果: \(createSuccess)")
//		}
//	}
}
