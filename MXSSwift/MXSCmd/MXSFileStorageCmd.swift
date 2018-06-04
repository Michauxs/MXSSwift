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
	
    let videoSufix = ["mp4", "MP4", "avi", "wmv", "flv", "mov", "MOV", "3gp", "mpg", "rm", "rmvb"]
    let imageSufix = ["mp4", "MP4", "avi", "wmv", "flv", "mov", "MOV", "3gp", "mpg", "rm", "rmvb"]
	
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
    
    //MARK:IMAGE
    public func enumImagesFileName() -> Array<String> {
        
        let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let imageDirPath = docuDir.first?.appending("/IMAGE")
        
        var directory: ObjCBool = ObjCBool(false)
        let isExists = FileManager.default.fileExists(atPath: imageDirPath!, isDirectory: &directory)
        if (directory.boolValue == false || isExists == false) {
            try? FileManager.default.createDirectory(at: URL.init(string: imageDirPath!)!, withIntermediateDirectories: true, attributes: nil)
        }
        
        var ilges = Array<String>.init()
        if let fileNameList = try? FileManager.default.contentsOfDirectory(atPath: imageDirPath!) {
            for name in fileNameList {
                MXSLog(name)
                ilges.append(name)
            }
        }
        return ilges
    }
    
    public func loadImageWithName (_ name:String) -> UIImage {
        let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let imagePath = docuDir.first?.appending("/IMAGE/").appending(name)
        
        var img = UIImage.init(contentsOfFile: imagePath!)
        if img == nil {
            img = UIImage.init(named: "default_img")
        }
        return img!
    }
    
    public func loadImageDataWithName (_ name:String) -> NSData {
        let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let imagePath = docuDir.first?.appending("/IMAGE/").appending(name)
        
        guard let data = NSData.init(contentsOfFile: imagePath!) else {
            return NSData.init()
        }
        return data
    }
    
    public func delImageWithName (_ name:String) {
        let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let imagePath = docuDir.first?.appending("/IMAGE/").appending(name)
        
        do {
            try FileManager.default.removeItem(atPath: imagePath!)
        } catch {
            
        }
    }
}
