//
//  MXSALAssetCmd.swift
//  MXSSwift
//
//  Created by Alfred Yang on 28/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import AssetsLibrary

class MXSALAssetCmd: NSObject {
	
	static public let shard = MXSALAssetCmd()
	let assetsLibrary =  ALAssetsLibrary()
	var assets = [ALAsset]()
	
	public func enumALAsset(completeBlock:@escaping (_ assets:Array<ALAsset>) -> Void) {
	
		MXSLog("is go go")
		assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupSavedPhotos, usingBlock: { (group: ALAssetsGroup!, stop) in
			MXSLog("is go in")
			if group != nil {
				let assetBlock : ALAssetsGroupEnumerationResultsBlock = { (result: ALAsset!, index: Int, stop) in
					if result != nil {
						self.assets.append(result)
					}
				}
				group.enumerateAssets(assetBlock)
				MXSLog("is go on")
				completeBlock(self.assets)
			}
			
		}, failureBlock: { (fail) in
			MXSLog(fail as Any)
		})
	}
	
//	public func loadingAlasset (assets:UnsafeMutablePointer<Array<ALAsset>>, completeBlock:@escaping () -> Void) {
//
//		MXSLog("is go go")
//		ALAssetsLibrary().enumerateGroupsWithTypes(ALAssetsGroupSavedPhotos, usingBlock: { (group: ALAssetsGroup!, stop) in
//			MXSLog("is go in")
//			if group != nil {
//				let assetBlock : ALAssetsGroupEnumerationResultsBlock = { (result: ALAsset!, index: Int, stop) in
//					if result != nil {
//						assets.move().append(result)
//					}
//				}
//				group.enumerateAssets(assetBlock)
//				MXSLog("is go on")
//				completeBlock()
//			}
//
//		}, failureBlock: { (fail) in
//			MXSLog(fail as Any)
//		})
//	}
	
	//获取缩略图
	public func getThumImage(asset:ALAsset) -> UIImage {
		return UIImage.init(cgImage: asset.thumbnail().takeUnretainedValue())
//		if asset != nil {
//		} else {
//			return UIImage.init(named: "default_img")!
//		}
	}
	
	//获取原图
	public func getOriginalImage(asset:ALAsset) -> UIImage {
		
		//获取文件名
		let representation =  asset.defaultRepresentation()
		let b_size:Int = Int(representation!.size())
		let imageBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(representation!.size()))
		let bufferSize = representation?.getBytes(imageBuffer, fromOffset: Int64(0), length: b_size, error: nil)
		let data =  NSData(bytesNoCopy:imageBuffer ,length:bufferSize!, freeWhenDone:true)
		return UIImage(data: data as Data)!
	}
	
	//获取图片信息
	//				textView.text = "日期：\(myAsset.valueForProperty(ALAssetPropertyDate))\n"
	//					+ "类型：\(myAsset.valueForProperty(ALAssetPropertyType))\n"
	//					+ "位置：\(myAsset.valueForProperty(ALAssetPropertyLocation))\n"
	//					+ "时长：\(myAsset.valueForProperty(ALAssetPropertyDuration))\n"
	//					+ "方向：\(myAsset.valueForProperty(ALAssetPropertyOrientation))"
}
