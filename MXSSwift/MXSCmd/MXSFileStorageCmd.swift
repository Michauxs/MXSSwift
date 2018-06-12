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
	
    let DOCUMENTSDIRECT = "/Documents"
    let IMAGEDIRECT = "/IMAGE"
    let TEXTDIRECT = "/TEXT"
    
    let videoSufix = ["mp4", "MP4", "avi", "wmv", "flv", "mov", "MOV", "3gp", "mpg", "rm", "rmvb"]
    let imageSufix = ["jpg", "JPG", "png", "PNG", "gif", "GIF", "bmp", "BMP", "jpeg", "JPEG"]
	
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
        let imageDirPath = docuDir.first?.appending(IMAGEDIRECT)
        
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
        let imagePath = docuDir.first?.appending(IMAGEDIRECT).appending("/").appending(name)
        
        var img = UIImage.init(contentsOfFile: imagePath!)
        if img == nil {
            img = UIImage.init(named: "default_img")
        }
        return img!
    }
    
    public func loadImageDataWithName (_ name:String) -> NSData {
        let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let imagePath = docuDir.first?.appending(IMAGEDIRECT).appending("/").appending(name)
        
        guard let data = NSData.init(contentsOfFile: imagePath!) else {
            return NSData.init()
        }
        return data
    }
    
    public func delImageWithName (_ name:String) {
        let imagePath = NSHomeDirectory().appending(DOCUMENTSDIRECT).appending(IMAGEDIRECT).appending("/").appending(name)
        
        do {
            try FileManager.default.removeItem(atPath: imagePath)
        } catch {
            
        }
    }
    
    
    //MARK:IMAGE
    public func enumTextFileName() -> Array<String> {
        
        let textDirPath = NSHomeDirectory().appending(DOCUMENTSDIRECT).appending(TEXTDIRECT)
        var ilges = Array<String>.init()
        
        var directory: ObjCBool = ObjCBool(false)
        let isExists = FileManager.default.fileExists(atPath: textDirPath, isDirectory: &directory)
        if !(directory.boolValue == true && isExists == true) {
            do {
              try FileManager.default.createDirectory(atPath: textDirPath, withIntermediateDirectories: true, attributes: nil)
            } catch {  }
        }
        
        if let list = try? FileManager.default.contentsOfDirectory(atPath: textDirPath) {
            for name in list {
                MXSLog(name)
                ilges.append(name)
            }
        }
        return ilges
    }
    
    public func loadTextWithName (_ name:String) -> String {
        let filePath = NSHomeDirectory().appending(DOCUMENTSDIRECT).appending(TEXTDIRECT).appending("/").appending(name)
        guard let txt = try? String.init(contentsOfFile: filePath, encoding: .utf8) else {
            return "无法识别文件编码"
        }
        return txt
    }
    
    public func delTextWithName (_ name:String) {
        let filePath = NSHomeDirectory().appending(DOCUMENTSDIRECT).appending(TEXTDIRECT).appending("/").appending(name)
        do {
            try FileManager.default.removeItem(atPath: filePath)
        } catch {
            
        }
    }
    
    public func saveTextFile (_ content: String, name:String) {
        
        let filePath = NSHomeDirectory().appending(DOCUMENTSDIRECT).appending(TEXTDIRECT).appending("/").appending(name)
//        do {
//            try content.write(toFile: filePath, atomically: true, encoding: .utf8)
//            
//        } catch {
//            
//        }
        guard ((try? content.write(toFile: filePath, atomically: true, encoding: .utf8)) != nil) else {
            return
        }
        MXSLog("save:\(name)")
    }
}
