//
//  MXSImagePickerVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 27/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import Photos

class MXSPickImgVC: MXSBaseVC {
	
	var collectionView : MXSCollectionView?
	var queryData : PHFetchResult<PHAsset>?
	
	override func viewDidLoad() {
		
		super.viewDidLoad();
		
		bindingNavBar()
		
		let layout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = UICollectionViewScrollDirection.vertical
		layout.minimumLineSpacing = 3
		layout.minimumInteritemSpacing = 3
		
		collectionView = bindingCollectionView(layout: layout)
		CollectionLayout()
		
		MXSPHAssetCmd.shard.enumPHAssets { (assets) in
			(self.collectionView?.dlg as! MXSPickImgCDlg).queryDataSub = assets
			self.queryData = assets
//			MXSLog(assets as Any)
			
			DispatchQueue.main.async{
				self.collectionView?.reloadData()
			}
		}
//		MXSALAssetCmd.shard.enumALAsset { (assets) in
//			self.collectionView?.dlg?.queryData = assets
//			MXSLog(assets as Any)
//			self.collectionView?.reloadData()
//		}
	}
	
	//MARK: layout
	override func NavBarLayout() {
		super.NavBarLayout()
		NavBar?.titleLabel?.text = "Photos"
		NavBar?.rightBtn?.isHidden = true
//		NavBar?.leftBtn?.isHidden = true
	}
	
	func CollectionLayout () {
		collectionView?.snp.makeConstraints({ (make) in
			make.edges.equalTo(self.view).inset(UIEdgeInsets.init(top: S_N_BAR_H, left: 0, bottom: 0, right: 0))
		})

		let w_h = (SCREEN_WIDTH - 10) / 4
		collectionView?.register(cellName: "MXSPickImgItem", delegate: MXSPickImgCDlg(), vc: self, itemSize: CGSize.init(width: w_h, height: w_h))
	}
	
	//MARK:notifies
	override func didNavBarRightClick() {
		
	}
	
	override func collectionSelectedRowAt(_ indexPath: IndexPath) {
		
		let asset = queryData![indexPath.row] as PHAsset
		let orig = MXSPHAssetCmd.shard.getOriginalImage(asset: asset)
		
		MXSVCExchangeCmd.shared.SourseVCPop(sourse: self, args: orig as Any)
	}
	
	
}
