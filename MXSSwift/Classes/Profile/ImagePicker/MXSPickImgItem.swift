//
//  MXSPickImgItem.swift
//  MXSSwift
//
//  Created by Alfred Yang on 28/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import Photos

class MXSPickImgItem: MXSCollectionViewCell {
	
	var coverImage : UIImageView?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		coverImage = UIImageView.init(image: UIImage.init(named: "default_img"))
		coverImage?.resizeScaleAspectFill()
		addSubview(coverImage!)
		coverImage?.snp.makeConstraints({ (make) in
			make.edges.equalTo(self)
		})
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var cellData : Any? {
		didSet {
			
			guard cellData != nil else {
				return
			}
			
			coverImage?.image = MXSPHAssetCmd.shard.getAssetThumbnail(asset: cellData as! PHAsset)
		}
	}
}
