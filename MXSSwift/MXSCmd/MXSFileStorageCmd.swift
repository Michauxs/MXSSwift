//
//  MXSFileStorageCmd.swift
//  MXSSwift
//
//  Created by Alfred Yang on 28/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSFileStorageCmd: NSObject {
	
//	let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

	static let shared = MXSFileStorageCmd()
	
	let videoSufix = ["mp4", "avi", "wmv", "flv", "mov", "3gp", "mpg", "rm", "rmvb"]
	
	public func enumVideoFileNameList() -> Array<String> {
		let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		let fileNameList = try? FileManager.default.contentsOfDirectory(atPath: docuDir.first!)
		
		var ilges = Array<String>.init()
		for name in fileNameList! {
			print(name)
			
			if let sufix = name.components(separatedBy: ".").last {
				if videoSufix.contains(sufix) {
					ilges.append(name)
				}
			}
			
		}
		
		return ilges
	}
}
