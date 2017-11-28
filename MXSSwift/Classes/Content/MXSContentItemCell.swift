//
//  MXSContentItemCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 27/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import AssetsLibrary

class MXSContentItemCell: MXSCollectionViewCell {
	
	var coverImage : UIImageView?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		coverImage = UIImageView.init(image: UIImage.init(named: "default_img"))
		addSubview(coverImage!)
		coverImage!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.edges.equalTo()(self)
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
//			coverImage?.image = MXSALAssetCmd.shard.getThumImage(asset: cellData as! ALAsset)
			coverImage?.image = cellData as? UIImage
		}
	}
}
