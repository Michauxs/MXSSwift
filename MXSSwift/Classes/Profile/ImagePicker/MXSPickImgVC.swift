//
//  MXSImagePickerVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 27/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import AssetsLibrary

class MXSPickImgVC: MXSBaseVC {
	
	var assetsLibrary =  ALAssetsLibrary()
	var assets = [ALAsset]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		bindingNavBar()
		let coverImage = UIImageView.init(image: UIImage.init(named: "default_img"))
		view.addSubview(coverImage)
		coverImage.snp.makeConstraints { (make) in
			make.center.equalTo(view)
			make.size.equalTo(CGSize.init(width: SCREEN_WIDTH, height: SCREEN_WIDTH))
		}
		
		MXSALAssetCmd.shard.enumALAsset { (assets) in
			coverImage.image = MXSALAssetCmd.shard.getOriginalImage(asset: assets[0])
		}
		
	}
}
