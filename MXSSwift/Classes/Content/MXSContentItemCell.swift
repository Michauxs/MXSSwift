//
//  MXSContentItemCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 27/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos

class MXSContentItemCell: MXSCollectionViewCell {
	
	var coverImage : UIImageView?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		coverImage = UIImageView.init(image: UIImage.init(named: "default_img"))
		coverImage?.resizeScaleAspectFill()
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
//			coverImage?.image = cellData as? UIImage
			coverImage?.image = MXSPHAssetCmd.shard.getAssetThumbnail(asset: cellData as! PHAsset)
//			let opt = PHImageRequestOptions()
//			opt.isSynchronous = true
//			PHImageManager.default().requestImage(for: cellData as! PHAsset, targetSize: CGSize.init(width: 60, height: 60), contentMode: PHImageContentMode.aspectFit, options: opt, resultHandler: { (thum, info) in
//				DispatchQueue.main.async {
//
//					self.coverImage?.image = thum
//				}
//			})
		}
	}
}
