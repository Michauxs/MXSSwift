//
//  MXSPickImgCDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 28/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import Photos

class MXSPickImgCDlg: MXSCollectionDlg {
	
	var queryDataSub: PHFetchResult<PHAsset>?
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return queryDataSub?.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName!, for: indexPath) as! MXSPickImgItem
		cell.cellData = queryDataSub?[indexPath.row]
		return cell
	}
}
