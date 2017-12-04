//
//  MXSContentCDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 28/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import Photos

class MXSContentCDlg: MXSCollectionDlg {
	
	var queryData_content: PHFetchResult<PHAsset>?
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return queryData_content?.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell:MXSContentItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName!, for: indexPath) as! MXSContentItemCell
		cell.cellData = queryData?[indexPath.row]
		return cell
	}
	
}
