//
//  MXSImagePickerVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 27/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import AssetsLibrary

class MXSImagePickerVC: MXSBaseVC {
	//资源库管理类
	var assetsLibrary =  ALAssetsLibrary()
	//保存照片集合
	var assets = [ALAsset]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var countOne:Int = 0
		//ALAssetsGroupSavedPhotos表示只读取相机胶卷（ALAssetsGroupAll则读取全部相簿）
		assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupSavedPhotos, usingBlock: { (group: ALAssetsGroup!, stop) in
			MXSLog("is goin")
			if group != nil {
				let assetBlock : ALAssetsGroupEnumerationResultsBlock = { (result: ALAsset!, index: Int, stop) in
					if result != nil {
						self.assets.append(result)
						countOne+=1
					}
				}
				group.enumerateAssets(assetBlock)
				MXSLog("assets:\(countOne)")
				let img = self.assets[0].thumbnail().takeUnretainedValue()
				MXSLog(img)
			}
			
		}, failureBlock: { (fail) in
			MXSLog(fail as Any)
		})
	}
}
