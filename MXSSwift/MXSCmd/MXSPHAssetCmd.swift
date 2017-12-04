//
//  MXSPHAssetCmd.swift
//  MXSSwift
//
//  Created by Alfred Yang on 4/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import Photos

class MXSPHAssetCmd: NSObject {

	static public let shard = MXSPHAssetCmd()
	
	public func enumPHAssets(completeBlock:@escaping (_ assets:PHFetchResult<PHAsset>) -> Void) {
		//申请权限
		PHPhotoLibrary.requestAuthorization({ (status) in
			if status != .authorized {
				return
			}
			
			//则获取所有资源
			
			let allPhotosOptions = PHFetchOptions()
			//按照创建时间倒序排列
			allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
			//只获取图片
			allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
			
			let assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
			completeBlock(assetsFetchResults)
			
			MXSLog(assetsFetchResults, "PHassets:")
			// 初始化和重置缓存
//			self.imageManager = PHCachingImageManager()
//			self.resetCachedAssets()
			
			//collection view 重新加载数据
			//		DispatchQueue.main.async{
			//			self.collectionView?.reloadData()
			//		}
			
			assetsFetchResults.enumerateObjects({ (asset, i, nil) in
				//获取每一个资源(PHAsset)
				print("\(asset)")
			})
		})
	}
	
	public func getAssetThumbnail(asset:PHAsset) -> UIImage {
		var img : UIImage?
		let opt = PHImageRequestOptions()
		opt.isSynchronous = true
//		DispatchQueue.global().async {
//		}
//		let sema = DispatchSemaphore.init(value: 0)
//		sema.signal()
//		sema.wait(timeout: (DispatchTime.now()+30))
		PHImageManager.default().requestImage(for: asset, targetSize: CGSize.init(width: 60, height: 60), contentMode: PHImageContentMode.aspectFit, options: opt, resultHandler: { (thum, info) in
			img = thum
		})
		return img!
	}
	
}