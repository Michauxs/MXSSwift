//
//  MXSDocumentCmd.swift
//  MXSSwift
//
//  Created by Alfred Yang on 18/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import CoreData

class MXSDocumentCmd: NSObject {

	static public let shared = MXSDocumentCmd()
	
//	lazy var document: UIManagedDocument = {
//
//		let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//		let path = (dir! as NSString).appendingPathComponent("diary_data.sqlite")
//		let url = NSURL.init(fileURLWithPath: path)
//		_ = FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
//
//		let doc = UIManagedDocument.init(fileURL: url as URL)
//
////		let opts = [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true]
////		doc.persistentStoreOptions = opts
//
//		var isDir : ObjCBool = ObjCBool(false)
//		if !FileManager.default.fileExists(atPath: url.path!, isDirectory: &isDir) {
//			doc.save(to: url as URL, for: .forCreating, completionHandler: { (success) in
//				self.enumLocalDBComplete(doc)
//			})
//		} else if doc.documentState == .closed {
//
//			doc.open(completionHandler: { (success) in
//				if success {
//					self.enumLocalDBComplete(doc)
//				} else {
//					MXSLog("open filed")
//				}
//			})
//		} else if doc.documentState == .inConflict {
//			doc.save(to: url as URL, for: .forOverwriting, completionHandler: { (success) in
//				self.enumLocalDBComplete(doc)
//			})
//		}
//
//		return doc
//	}()
	
//	lazy var managedContext: NSManagedObjectContext = {
//		return self.document.managedObjectContext
//	}()
	
	var document: UIManagedDocument?
	
	public func getDocument() -> UIManagedDocument {
		
//		let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
		let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
		let path = (dir! as NSString).appendingPathComponent("diary_data.sqlite")
		let url = NSURL.init(fileURLWithPath: path)
		
//		_ = FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
		
		let doc = UIManagedDocument.init(fileURL: url as URL)
		
		//		let opts = [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true]
		//		doc.persistentStoreOptions = opts
		
		var isDir : ObjCBool = ObjCBool(false)
		if !FileManager.default.fileExists(atPath: url.path!, isDirectory: &isDir) {
			doc.save(to: url as URL, for: .forCreating, completionHandler: { (success) in
				self.enumLocalDBComplete(doc)
			})
		} else if doc.documentState == .closed {
			
			doc.open(completionHandler: { (success) in
				if success {
					self.enumLocalDBComplete(doc)
				} else {
					MXSLog("open filed")
				}
			})
		} else if doc.documentState == .inConflict {
			doc.save(to: url as URL, for: .forOverwriting, completionHandler: { (success) in
				self.enumLocalDBComplete(doc)
			})
		}
		
		return doc
	}
	
	func enumLocalDBComplete(_ document:UIManagedDocument) {
		document.managedObjectContext.perform {
			
			MXSLog("local db complete")
		}
	}
	
}
