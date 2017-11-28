//
//  MXSContentVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSContentVC: MXSBaseVC {
	
	var collectionView : MXSCollectionView?
	
	override func viewDidLoad() {
		super.viewDidLoad();
		self.view.backgroundColor = UIColor.white;
		
		bindingNavBar()
		
		let layout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = UICollectionViewScrollDirection.vertical
		layout.minimumLineSpacing = 5
		layout.minimumInteritemSpacing = 5
		
		collectionView = bindingCollectionView(layout: layout)
		CollectionLayout()
		
		MXSALAssetCmd.shard.enumALAsset { (assets) in
//			self.collectionView?.dlg?.queryData = assets
			MXSLog(assets as Any)
			
			var images = [UIImage]()
			for asset in assets {
				images.append(MXSALAssetCmd.shard.getThumImage(asset: asset))
			}
			self.collectionView?.dlg?.queryData = images
			self.collectionView?.reloadData()
		}
	}
	
	//MARK: layout
	override func NavBarLayout() {
		NavBar?.titleLabel?.text = "Photos"
		NavBar?.rightBtn?.isHidden = true
		NavBar?.leftBtn?.isHidden = true
	}
	
	func CollectionLayout () {
		collectionView!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.top.equalTo()(view)?.offset()(S_N_BAR_H)
			make.left.equalTo()(view)
			make.right.equalTo()(view)
			//			make.height.mas_equalTo()(250)
			make.bottom.equalTo()(view)
		})
//		let col:CGFloat = 4
		let w_h = (SCREEN_WIDTH - 15 - 1) / 4
//		let w_h = SCREEN_WIDTH / 2
		collectionView?.register(cellName: "MXSContentItemCell", delegate: MXSCollectionDlg(), vc: self, itemSize: CGSize.init(width: w_h, height: w_h))
	}
	
}
